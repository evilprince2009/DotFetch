## Posh-Winfetch

### A command line utility for fetching system information

Posh-Winfetch is a command-line system information utility written in PowerShell for Windows. Posh-Winfetch displays information about your operating system, software and hardware in an way similar to Neofetch. But this one is little more enhanced than original Winfetch. The original [Winfetch](https://github.com/lptstr/winfetch) can be found here. I basically took the Winfetch and built it the way I like.

![Image](<https://raw.githubusercontent.com/evilprince2009/Posh-Winfetch-remake/main/Screenshot%20(53).png>)

### This is how it looks like

### [Download](https://github.com/evilprince2009/Posh-Winfetch-remake/releases/tag/v1.0.0) it here.

### Installation

Follow these simple steps to install Posh-Winfetch:

- Set your execution policy to RemoteSigned by running `Set-ExecutionPolicy RemoteSigned` on an Administrative instance of PowerShell. This is required to run Posh-Winfetch.
- Install `posh-git` from https://www.powershellgallery.com/packages/posh-git/0.7.1 and `oh-my-posh` from https://www.powershellgallery.com/packages/oh-my-posh/2.0.496 , installing the exact version provided is required in order to work this script properly.
- Download the files from provided link and extract them.
- Put the `posh-winfetch.ps1` inside the `C:\Program Files\WindowsPowerShell\Scripts` directory. Don't worry , there is nothing malicious.
- Put this directory 'C:\Program Files\WindowsPowerShell\Scripts' into path under Environment Variables.
- Now open PowerShell & type `notepad $profile`.
- Put `posh-winfetch` inside the file without quotation marks and save.
- Re-Launch PowerShell & you are good to go.

#### [Ibne Nahian](https://evilprince2009.netlify.app/)
