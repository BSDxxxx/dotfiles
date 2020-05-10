str=$(task add project:考研 +政治             due:<++> <++>)
id=$(echo $str | grep -o -E '[0-9]+')

str=$(task add project:考研 +政治 depends:$id due:<++> <++>)
id=$(echo $str | grep -o -E '[0-9]+')

# ---------------------------------------------------------
task add project:筑基 +休息                   due:<++> 眼药水 & 按摩器
task add project:筑基 +动功                   due:<++> <++>
# ---------------------------------------------------------

str=$(task add project:考研 +专业 depends:$id due:<++> <++>)
id=$(echo $str | grep -o -E '[0-9]+')

str=$(task add project:考研 +专业 depends:$id due:<++> <++>)
id=$(echo $str | grep -o -E '[0-9]+')
