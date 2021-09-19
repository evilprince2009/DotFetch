## Posh-Winfetch

### A command line utility for fetching system information

Posh-Winfetch is a command-line system information utility written in PowerShell for Windows. Posh-Winfetch displays information about your operating system, software and hardware in an way similar to Neofetch. But this one is little more enhanced than original Winfetch. The original _[Winfetch](https://github.com/lptstr/winfetch)_ can be found here. I basically took the Winfetch and built it the way I like.

![Posh-Winfetch](<https://github.com/evilprince2009/Posh-Winfetch-remake/blob/main/Screenshot%20(55).png>)

### This is how it looks like

=> [Download](https://github.com/evilprince2009/Posh-Winfetch-remake/) it here.

### Installation

Follow these simple steps to install Posh-Winfetch:

- Set your execution policy to RemoteSigned by running `Set-ExecutionPolicy RemoteSigned` on an Administrative instance of PowerShell. This is required to run Posh-Winfetch.
- Install `posh-git` from _[here](https://www.powershellgallery.com/packages/posh-git/)_ and `oh-my-posh` from _[here](https://www.powershellgallery.com/packages/oh-my-posh/)_. Installing these modules provided is required in order to work this script properly. From now you will be able to use the latest version of `posh-git` and `oh-my-posh` , legacy version dependencies are removed.
- Download the files from provided link and extract them.
- Put the `posh-winfetch.ps1` inside the `C:\Program Files\WindowsPowerShell\Scripts` directory. Don't worry , there is nothing malicious.
- Put this directory `C:\Program Files\WindowsPowerShell\Scripts` into path under Environment Variables.
- Now open PowerShell & type `notepad $profile`.
- Put below lines inside the file and save.

```
Import-Module posh-git
Import-Module oh-my-posh
Set-PoshPrompt -Theme Iterm2
Write-Host("                        =========> Wellcome || Windows PowerShell <=========")
posh-winfetch
```

You can run `Get-PoshThemes` command on terminal to see all available color themes change it here like `Set-PoshPrompt -Theme Iterm2` to `Set-PoshPrompt -Theme Paradox`.

- Re-Launch PowerShell & you are good to go.

#### [Ibne Nahian](https://evilprince2009.netlify.app/)
