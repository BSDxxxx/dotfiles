doskey ls=dir /b $*
doskey ll=dir $*
doskey vi=nvim-qt --no-ext-popupmenu --no-ext-tabline $*
doskey ..=cd ..
doskey ~=cd C:\Users\zyx
doskey ex=explorer $*
doskey q=exit
doskey c=chezmoi $*
doskey caps2esc=c2e
set ~=C:\Users\zyx
for /F %%i in ('chezmoi source-path') do (set chezmoi source-path=%%i)
chcp 65001
