elseif (-not $noimage.IsPresent -and $image) {
    if (-not (Get-Command -Name magick -ErrorAction Ignore)) {
        Write-Output 'error: Imagemagick must be installed to print custom images.' -f red
        Write-Output 'hint: if you have Scoop installed, try `scoop install imagemagick`.' -f yellow
        exit 1
    }

    $COLUMNS = 35
    $CURR_ROW = ""
    $CHAR = [Text.Encoding]::UTF8.GetString(@(226, 150, 128)) # 226,150,136
    $upper, $lower = @(), @()

    if ($image -eq 'wallpaper') {
        $image = (Get-ItemProperty -Path 'HKCU:\Control Panel\Desktop' -Name Wallpaper).Wallpaper
    }
    if (-not (test-path -path $image)) {
        Write-Output 'Specified image or wallpaper does not exist.' -f red
        exit 1
    }
    $pixels = @((magick convert -thumbnail "${COLUMNS}x" -define txt:compliance=SVG $image txt:-).Split("`n"))
    foreach ($pixel in $pixels) {
        $coord = [regex]::Match($pixel, "([0-9])+,([0-9])+:").Value.TrimEnd(":") -split ','
        $col, $row = $coord[0, 1]

        $rgba = [regex]::Match($pixel, "\(([0-9])+,([0-9])+,([0-9])+,([0-9])+\)").Value.TrimStart("(").TrimEnd(")").Split(",")
        $r, $g, $b = $rgba[0, 1, 2]

        if (($row % 2) -eq 0) {
            $upper += "${r};${g};${b}"
        } else {
            $lower += "${r};${g};${b}"
        }

        if (($row % 2) -eq 1 -and $col -eq ($COLUMNS - 1)) {
            $i = 0
            while ($i -lt $COLUMNS) {
                $CURR_ROW += "${e}[38;2;$($upper[$i]);48;2;$($lower[$i])m${CHAR}"
                $i++
            }
            "${CURR_ROW}${e}[0m"

            $CURR_ROW = ""
            $upper = @()
            $lower = @()
        }
    }
}


$strings.pkgs = if ($configuration.HasFlag([Configuration]::Show_Pkgs)) {
    $chocopkg = if (Get-Command -Name choco -ErrorAction Ignore) {
        (& clist -l)[-1].Split(' ')[0] - 1
    }

    $scooppkg = if (Get-Command -Name scoop -ErrorAction Ignore) {
        $scoop = & scoop which scoop
        $scoopdir = (Resolve-Path "$(Split-Path -Path $scoop)\..\..\..").Path
        (Get-ChildItem -Path $scoopdir -Directory).Count - 1
    }

    $(if ($scooppkg) {
        "$scooppkg (scoop)"
    }
    if ($chocopkg) {
        "$chocopkg (choco)"
    }) -join ', '
} else {
    $disabled
}