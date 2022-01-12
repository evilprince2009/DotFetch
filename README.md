# DotFetch

## A command line utility for fetching system information

DotFetch is a command-line system information utility written in PowerShell for Windows. DotFetch displays information about your operating system, software and hardware in an way similar to NeoFetch. DotFetch is basically partial NeoFetch clone written from scratch with the same ideology. The original _[NeoFetch](https://github.com/dylanaraps/neofetch)_ can be found here.

### Compatible with both Windows PowerShell & PowerShell Core

### Windows PowerShell on Windows Terminal

![DotFetch Win](https://github.com/evilprince2009/DotFetch/blob/main/Images/Windows%20Powershell.png)

### PowerShell Core on Windows Terminal

![DotFetch Core](https://github.com/evilprince2009/DotFetch/blob/main/Images/PowerShell%20Core.png)

### PowerShell Core on Windows Terminal (Windows 11)

![DotFetch Core Win XI](https://github.com/evilprince2009/DotFetch/blob/main/Images/PowerShell%20Core%20Win%2011.png)

### PowerShell Core on Hyper Terminal

![DotFetch Core - Hyper](https://github.com/evilprince2009/DotFetch/blob/main/Images/hyper-pscore.png)

### PowerShell Core on Windows Console

![DotFetch Core - Console](https://github.com/evilprince2009/DotFetch/blob/main/Images/Console%20PSCore.png)

### This is how it looks like

### [Download](https://github.com/evilprince2009/DotFetch) it here

### Installation

Follow these simple steps to install DotFetch:

- Set your execution policy to RemoteSigned by running `Set-ExecutionPolicy RemoteSigned` on an Administrative instance of PowerShell. This is required to run DotFetch.
- Download the files from provided link and extract them.
- Put the `dotfetch.ps1` inside the `C:\Program Files\WindowsPowerShell\Scripts` directory. Don't worry , there is nothing malicious.
- Put this directory `C:\Program Files\WindowsPowerShell\Scripts` into path under Environment Variables.
- Now open PowerShell , type `notepad $profile` and hit **Enter**.
- Put below line inside the file and save.

```
dotfetch
```

- Re-Launch PowerShell & you are good to go.

#### [Ibne Nahian](https://evilprince2009.netlify.app/)
