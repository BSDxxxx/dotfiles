# dotfiles
Backup some config files for linux, apps, etc.

- .bashrc  
位于linux用户家目录下,每个基于bash的终端打开时执行其中的命令.

- .zshrc  
位于linux用户家目录下,每个基于zsh的终端开始时执行其中的命令.

- vimrc  
Vim config file

- .vimrc  
[iVim](https://github.com/terrychou/iVim) config file

- cacert.pem  
To use curl in iVim, put this file into iVim's root directory.

- nvim  
Neovim config file, cmd创建目录连接: mklink /J C:\Users\xxx\AppData\Local\nvim nvim

- init.toml  
SpaceVim config file

- ls colors  
Check at [Linux ls command's color option](http://www.linux-sxs.org/housekeeping/lscolors.html) or [here](https://www.cnblogs.com/storymedia/archive/2010/03/18/4436171.html)

- termux.properties  
Config for Android app 'termux' bottom asist line.

- Soul_Knight  
元气骑士存档修改文件备份

- userstyle.css  
Joplin自定义样式

- auto.bat  
Win10CMD窗口启动执行脚本,在注册表\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Command Processor\AutoRun or\HKEY_CURRENT_USER\SOFTWARE\Microsoft\Command Processor\AutoRun填入此脚本的位置即可生效，不过这样可能会导致一些问题：依赖于终端窗口的一些软件如nvim会报错;也可以放在C:\Windows下或添加到环境变量，每次在CMD执行auto来生效

- ff.cfg  
Config file of [ff](https://github.com/genotrance/ff) (a fzf wraper on Windows)

- TeXmacs  
TeXmacs config file.

- Double Commander  
Double commander settings (vim like style).

- vnote  
VNote config file.
