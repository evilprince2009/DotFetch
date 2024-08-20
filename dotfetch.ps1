<#PSScriptInfo
.VERSION 2.2.0
.GUID 1c26142a-da43-4125-9d70-97555cbb1752
.DESCRIPTION DotFetch is a command-line system information utility for Windows written in PowerShell.
.AUTHOR Evilprince2009
.PROJECTURI https://github.com/evilprince2009/DotFetch
.COMPANYNAME
.COPYRIGHT
.TAGS
.LICENSEURI
.ICONURI
.EXTERNALMODULEDEPENDENCIES
.REQUIREDSCRIPTS
.EXTERNALSCRIPTDEPENDENCIES
.RELEASENOTES
#>
<#
.SYNOPSIS
    DotFetch - Neofetch for Windows in PowerShell 5+
.DESCRIPTION
    DotFetch is a command-line system information utility for Windows written in PowerShell.
.PARAMETER image
    Display a pixelated image instead of the usual logo. Imagemagick required.
.PARAMETER genconf
    Download a configuration template. Internet connection required.
.PARAMETER noimage
    Do not display any image or logo; display information only.
.PARAMETER help
    Display this help message.
.INPUTS
    System.String
.OUTPUTS
    System.String[]
.NOTES
    Run DotFetch without arguments to view core functionality.
#>
[CmdletBinding()]
param(
    [string][alias('i')]$image,
    [switch][alias('g')]$genconf,
    [switch][alias('n')]$noimage,
    [switch][alias('h')]$help
)

$e = [char]0x1B
$ee = "$e[0m"
$es = "$ee$e[5;37m"
$eh = "$ee$e[1;37;49m"
$eby = "$ee$e[5;33m"
$ebt = "$ee$e[5;36m"
$ebg = "$ee$e[5;32m"
$ebr = "$ee$e[5;31m"


$colorBar = ('{0}[0;40m{1}{0}[0;41m{1}{0}[0;42m{1}{0}[0;43m{1}' +
            '{0}[0;44m{1}{0}[0;45m{1}{0}[0;46m{1}{0}[0;47m{1}' +
            '{0}[0m') -f $e, '   '

$is_pscore = if ($PSVersionTable.PSEdition.ToString() -eq 'Core') {
    $true
} else {
    $false
}

$configdir = $env:XDG_CONFIG_HOME, "${env:USERPROFILE}\.config" | Select-Object -First 1
$config = "${configdir}/dotfetch/config.ps1"

$defaultconfig = 'https://github.com/evilprince2009/DotFetch/blob/main/lib/config.ps1'

# ensure configuration directory exists
if (-not (Test-Path -Path $config)) {
    [void](New-Item -Path $config -Force)
}

# ===== DISPLAY HELP =====
if ($help) {
    if (Get-Command -Name less -ErrorAction Ignore) {
        get-help ($MyInvocation.MyCommand.Definition) -full | less
    } else {
        get-help ($MyInvocation.MyCommand.Definition) -full
    }
    exit 0
}

# ===== GENERATE CONFIGURATION =====
if ($genconf.IsPresent) {
    if ((Get-Item -Path $config).Length -gt 0) {
        Write-Output 'ERROR: configuration file already exists!' -f red
        exit 1
    }
    "INFO: downloading default config to '$config'."
    Invoke-WebRequest -Uri $defaultconfig -OutFile $config -UseBasicParsing
    'INFO: successfully completed download.'
    exit 0
}

# ===== VARIABLES =====
$disabled = 'disabled'
$strings = @{
    ip_address = ''
    dashes = ''
    img = ''
    title = ''
    os = ''
    hostname = ''
    username = ''
    computer = ''
    uptime = ''
    terminal = ''
    cpu = ''
    gpu = ''
    memory = ''
    disk_c = ''
    pwsh = ''
    pkgs = ''
    admin = ''
    connection = ''
    battery = ''
    kernel = ''
    refresh_rate = ''
}

# ===== CONFIGURATION =====
[Flags()]
enum Configuration
{
    None = 0
    Show_Title = 1
    Show_Dashes = 2
    Show_OS = 4
    Show_Computer = 8
    Show_Uptime = 16
    Show_Terminal = 32
    Show_CPU = 64
    Show_GPU = 128
    Show_Memory = 256
    Show_Disk = 512
    Show_Pwsh = 1024
    Show_Pkgs = 2048
}
[Configuration]$configuration = if ((Get-Item -Path $config).Length -gt 0) {
    . $config
}
else {
    0xFFF
}

# ===== OS =====
$strings.os = (Get-CimInstance -ClassName CIM_OperatingSystem).Caption.ToString().TrimStart('Microsoft ')

# ===== LOGO =====
$img = if (-not $image -and -not $noimage.IsPresent -and $strings.os -Match 'Windows 10') {
    @(
            "                         $ebg....::::$eh       ",
            "                 $ebg....::::::::::::$eh       ",
            "        $ebr....::::$eh $ebg::::::::::::::::$eh       ",
            "$ebr....::::::::::::$eh $ebg::::::::::::::::$eh       ",
            "$ebr::::::::::::::::$eh $ebg::::::::::::::::$eh       ",
            "$ebr::::::::::::::::$eh $ebg::::::::::::::::$eh       ",
            "$ebr::::::::::::::::$eh $ebg::::::::::::::::$eh       ",
            "$ebr::::::::::::::::$eh $ebg::::::::::::::::$eh       ",
            "$eby................$eh $ebt................$eh       ",
            "$eby::::::::::::::::$eh $ebt::::::::::::::::$eh       ",
            "$eby::::::::::::::::$eh $ebt::::::::::::::::$eh       ",
            "$eby::::::::::::::::$eh $ebt::::::::::::::::$eh       ",
            "$eby''''::::::::::::$eh $ebt::::::::::::::::$eh       ",
            "        $eby''''::::$eh $ebt#EVILPRINCE2009#$eh       ",
            "                 $ebt''''::::::::::::$eh       ",
            "                         $ebt''''::::$eh       ",
            "                                                      ",
            "                                                      ",
            "                                                      ";
    )
} elseif (-not $image -and -not $noimage.IsPresent -and $strings.os -Match 'Windows 11') {
    @(
        "$ebt·$ee $ebr·$ee $eby·$ee $ebt·$ee $ebg·$ee $ebr·$ee $eby·$ee $ebt·$ee $ebg·$ee $ebr·$ee $eby·$ee $ebt·$ee $ebg·$ee $ebr·$ee $eby·$ee $ebt·$ee $ebg·$ee $ebt·$ee $es·$ee",
    "$eby·$ee $ebr################$eh$eby·$ee$ebg################$eh $ebr·$ee",
    "$ebt·$ee $ebr################$eh$es·$ee$ebg################$eh $ebt·$ee",
    "$ebg·$ee $ebr################$eh$ebr·$ee$ebg################$eh $eby·$ee",
    "$ebr·$ee $ebr################$eh$ebg·$ee$ebg################$eh $ebg·$ee",
    "$eby·$ee $ebr################$eh$ebt·$ee$ebg################$eh $eby·$ee",
    "$ebt·$ee $ebr################$eh$eby·$ee$ebg################$eh $ebt·$ee",
    "$ebg·$ee $ebr################$eh$es·$ee$ebg################$eh $ebg·$ee",
    "$ebr·$ee $ebr################$eh$ebr·$ee$ebg################$eh $ebr·$ee",
    "$eby·$ee $ebg·$ee $ebt·$ee $eby·$ee $ebr·$ee $ebg·$ee $ebt·$ee $eby·$ee $ebr·$ee $ebg·$ee $ebt·$ee $eby·$ee $ebr·$ee $ebg·$ee $ebt·$ee $eby·$ee $ebr·$ee $ebg·$ee $es·$ee",
    "$ebr·$ee $eby################$eh$eby·$ee$ebt################$eh $ebt·$ee",
    "$eby·$ee $eby################$eh$es·$ee$ebt################$eh $eby·$ee",
    "$ebt·$ee $eby################$eh$ebr·$ee$ebt################$eh $ebg·$ee",
    "$ebg·$ee $eby################$eh$ebg·$ee$ebt################$eh $ebr·$ee",
    "$ebr·$ee $eby################$eh$ebt·$ee$ebt################$eh $ebg·$ee",
    "$eby·$ee $eby################$eh$eby·$ee$ebt################$eh $eby·$ee",
    "$ebt·$ee $eby################$eh$es·$ee$ebt################$eh $ebt·$ee",
    "$ebg·$ee $eby################$eh$ebr·$ee$ebt################$eh $ebr·$ee",
    "$ebt·$ee $ebr·$ee $eby·$ee $ebt·$ee $ebg·$ee $ebr·$ee $eby·$ee $ebt·$ee $ebg·$ee $ebr·$ee $eby·$ee $ebt·$ee $ebg·$ee $ebr·$ee $eby·$ee $ebt·$ee $ebg·$ee $ebt·$ee $es·$ee"
    )
}
else {
    @()
}

# ===== HOSTNAME =====
$strings.hostname = $Env:COMPUTERNAME

# ===== USERNAME =====
$strings.username = [Environment]::UserName


# ===== TITLE =====
$strings.title = if ($configuration.HasFlag([Configuration]::Show_Title)) {
    "${e}[1;37m{0}${e}[0m@${e}[1;34m{1}${e}[0m" -f $strings['username', 'hostname']
}
else {
    $disabled
}


# ===== DASHES =====
$strings.dashes = if ($configuration.HasFlag([Configuration]::Show_Dashes)) {
    -join $(for ($i = 0; $i -lt ('{0}@{1}' -f $strings['username', 'hostname']).Length; $i++) { '-' })
} else {
    $disabled
}


# ===== COMPUTER =====
$strings.computer = if ($configuration.HasFlag([Configuration]::Show_Computer)) {
    $compsys = Get-CimInstance -ClassName Win32_ComputerSystem
    '{0} on host {1}' -f $compsys.Name, $compsys.Model
} else {
    $disabled
}


# ===== UPTIME =====
$strings.uptime = if ($configuration.HasFlag([Configuration]::Show_Uptime)) {
    $(switch ((Get-Date) - (Get-CimInstance -ClassName Win32_OperatingSystem).LastBootUpTime) {
        ({ $PSItem.Days -eq 1 }) { '1 day' }
        ({ $PSItem.Days -gt 1 }) { "$($PSItem.Days) days" }
        ({ $PSItem.Hours -eq 1 }) { '1 hour' }
        ({ $PSItem.Hours -gt 1 }) { "$($PSItem.Hours) hours" }
        ({ $PSItem.Minutes -eq 1 }) { '1 minute' }
        ({ $PSItem.Minutes -gt 1 }) { "$($PSItem.Minutes) minutes" }
    }) -join ' '
} else {
    $disabled
}

# ======= Refresh Rate =======

function Get-RefreshRate {
    return "$((Get-CimInstance -ClassName Win32_VideoController | Select-Object -Property CurrentRefreshRate).CurrentRefreshRate)Hz"
}

$strings.refresh_rate = Get-RefreshRate

# ===== TERMINAL =====
# this section works by getting
# the parent processes of the
# current powershell instance.
$strings.terminal = if ($configuration.HasFlag([Configuration]::Show_Terminal) -and $is_pscore) {
    $parent = (Get-Process -Id $PID).Parent
    for () {
        if ($parent.ProcessName -in 'powershell', 'pwsh', 'winpty-agent', 'cmd', 'zsh', 'bash') {
            $parent = (Get-Process -Id $parent.ID).Parent
            continue
        }
        break
    }
    try {
        switch ($parent.ProcessName) {
            'explorer' { 'Windows Console' }
            default { $PSItem }
        }
    } catch {
        $parent.ProcessName
    }
} else {
    $disabled
}

# ===== CPU/GPU =====
$strings.cpu = if ($configuration.HasFlag([Configuration]::Show_CPU)) {
    (Get-CimInstance -ClassName Win32_Processor).Name
} else {
    $disabled
}

$strings.gpu = if ($configuration.HasFlag([Configuration]::Show_GPU)) {
    (Get-CimInstance -ClassName Win32_VideoController).Name
} else {
    $disabled
}

# ===== MEMORY =====
$strings.memory = if ($configuration.HasFlag([Configuration]::Show_Memory)) {
    $m = Get-CimInstance -ClassName Win32_OperatingSystem
    $used = [math]::floor((($m.TotalVisibleMemorySize - $m.FreePhysicalMemory) / 1mb))
    ("{0}GiB / {1}GiB" -f $used,$total)
} else {
    $disabled
}

# ===== DISK USAGE C =====
$strings.disk_c = if ($configuration.HasFlag([Configuration]::Show_Disk)) {
    $disk = Get-CimInstance -ClassName Win32_LogicalDisk -Filter 'DeviceID="C:"'
    $total = [math]::floor(($disk.Size / 1gb))
    $used = [math]::floor((($disk.FreeSpace - $total) / 1gb))
    $usage = [math]::floor(($used / $total * 100))
    ("{0}GiB / {1}GiB ({2}%)" -f $used,$total,$usage)
} else {
    $disabled
}

# ===== Running as Admin ? =====
$current_thread = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())

$strings.admin = $current_thread.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

# ===== POWERSHELL VERSION =====
$strings.pwsh = if ($configuration.HasFlag([Configuration]::Show_Pwsh)) {
    "PowerShell v$($PSVersionTable.PSVersion)"
} else {
    $disabled
}

# ===== CONNECTION CHECKER =====
function Get-Status {
    $adaptor = (Test-NetConnection -WarningAction silentlycontinue)
    $status = 'Offline'
    if ($adaptor.PingSucceeded) {

        $interface_alias = $adaptor.InterfaceAlias
        $suffix = ""

        if ($interface_alias.Length -gt 0) {
           $suffix = "($($interface_alias))"
        }

        $connection_name = Get-NetIPConfiguration
        $status = "$($connection_name.NetProfile.Name) $($suffix)"
    }
    return $status
}

$strings.connection = Get-Status

# ===== IP Address =====

function Get-LocalIPAddress {
    $address = "127.0.0.1"
    if ($strings.connection -ne 'Offline') {
        $address = (Invoke-WebRequest -uri "https://api.ipify.org/").Content
    }
    return $address
}

$strings.ip_address = Get-LocalIpAddress

# ===== Kernel Version =====
$strings.kernel = [Environment]::OSVersion.Version.ToString()

# ===== Battery =====
function Get-ConnectionStatus {
    $charging_state = (Get-CimInstance win32_battery).batterystatus
    if ($charging_state -eq 2) {
        return 'Connected'
    } else {
        return 'Unplugged'
    }
}
$connection_sign = Get-ConnectionStatus
try {
    $strings.battery = (Get-CimInstance -ClassName Win32_Battery | Select-Object -ExpandProperty EstimatedChargeRemaining).ToString() + "% , " + $connection_sign
}
catch {
    $strings.battery = 'PC'
}
# ===== PACKAGES =====
function Get-PackageManager {
    $_pms = ''

    if ((Get-Command -Name scoop -ErrorAction Ignore).Name -eq 'scoop.exe') {
        $_pms += 'scoop '
    }
    if ((Get-Command -Name winget -ErrorAction Ignore).Name -eq 'winget.exe') {
        $_pms += 'winget '
    }
    
    if ((Get-Command -Name choco -ErrorAction Ignore).Name -eq 'choco.exe') {
        $_pms += 'choco '
    } 

    if ($_pms.Length -eq 0) {
        return '(none)'
    } else {
        return $_pms.Replace(' ', ', ').TrimEnd(', ')
    }
}

$strings.pkgs = Get-PackageManager

# Reset terminal sequences and display a newline
Write-Output "${e}[0m"

# Add system info into an array
$info = [collections.generic.list[string[]]]::new()
$info.Add(@("", $strings.title))
$info.Add(@("", $strings.dashes))
$info.Add(@("OS", $strings.os))
$info.Add(@("Kernel Version", $strings.kernel))
$info.Add(@("Host", $strings.computer))
$info.Add(@("Uptime", $strings.uptime))
$info.Add(@("Packages", $strings.pkgs))
$info.Add(@("Shell", $strings.pwsh))
$info.Add(@("Terminal", $strings.terminal))
$info.Add(@("CPU", $strings.cpu))


foreach($card in $strings.gpu) {
    if ($card.ToLower() -Match "nvidia") {
        $info.Add(@("GPU (dedicated)", $card))
    } else {
        $info.Add(@("GPU (shared)", $card))
    }
}
$info.Add(@("Refresh Rate", $strings.refresh_rate))
$info.Add(@("Memory", $strings.memory))
$info.Add(@("Disk (C:)", $strings.disk_c))
$info.Add(@("Running as Admin", $strings.admin))
$info.Add(@("Internet Access", $strings.connection))
$info.Add(@("IP Address", $strings.ip_address))
$info.Add(@("Power", $strings.battery))
$info.Add(@("",""))
$info.Add(@("", $colorBar))

# Write system information in a loop
$counter = 0
$logoctr = 0
while ($counter -lt $info.Count) {
    $logo_line = $img[$logoctr]
    $item_title = "$e[1;34m$($info[$counter][0])$e[0m"
    $item_content = if (($info[$counter][0]) -eq '') {
            $($info[$counter][1])
        } else {
            ": $($info[$counter][1])"
        }

    if ($item_content -notlike '*disabled') {
        " ${logo_line}$e[40G${item_title}${item_content}"
    }

    $counter++
    if ($item_content -notlike '*disabled') {
        $logoctr++
    }
}

# Print the rest of the logo
if ($logoctr -lt $img.Count) {
    while ($logoctr -le $img.Count) {
        " $($img[$logoctr])"
        $logoctr++
    }
}

# Print a newline
write-output ''

# Compatible with both Windows PowerShell & PowerShell Core
# Author: Ibne Nahian (@evilprince2009)
#
#  ___ ___  ___
# | __/ _ \| __|
# | _| (_) | _|
# |___\___/|_|
