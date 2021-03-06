chcp 65001

Set-PSReadlineOption -EditMode Emacs

function which($name) { Get-Command $name | Select-Object Definition }
function rmrf($item) { Remove-Item $item -Recurse -Force }
function mkfile($file) { "" | Out-File $file -Encoding ASCII }

Import-Module posh-git

Import-Module oh-my-posh

Set-Theme Agnoster
# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

# alias
Set-Alias c chezmoi
Set-Alias caps2esc c2e
Set-Alias vi nvim-qt
