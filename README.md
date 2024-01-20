# DotFetch

## A command line utility for fetching system information

DotFetch is a command-line system information utility written in PowerShell for Windows. DotFetch displays information about your operating system, software and hardware in an way similar to NeoFetch. DotFetch is basically partial NeoFetch clone written from scratch with the same ideology. The original _[NeoFetch](https://github.com/dylanaraps/neofetch)_ can be found here.

### Compatible with both Windows PowerShell & PowerShell Core

### PowerShell Core on Windows Terminal (Windows 11)

![DotFetch Core Win XI](https://github.com/evilprince2009/DotFetch/blob/main/Images/win-teriminal-win-xi-pwsh.gif)

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

## Ibne Nahian

### Hire me for your Web and Automation projects

- #### [Portfolio](https://evilprince2009.netlify.app/)
- #### [LinkedIn](https://www.linkedin.com/in/evilprince2009/)
- #### [Upwork](https://www.upwork.com/freelancers/~01ded0be5baccfa296)
