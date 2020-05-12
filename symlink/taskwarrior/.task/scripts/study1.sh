str=$(task add project:考研 +高数             due:today+2d <++>)
id=$(echo $str | grep -o -E '[0-9]+')

str=$(task add project:考研 +高数 depends:$id due:today+2d <++>)
id=$(echo $str | grep -o -E '[0-9]+')

# ---------------------------------------------------------
task add project:筑基 +休息                   due:today+2d '眼药水 & 按摩器'
task add project:筑基 +静功                   due:today+2d <++>
# ---------------------------------------------------------

str=$(task add project:考研 +英语 depends:$id due:today+2d <++>)
id=$(echo $str | grep -o -E '[0-9]+')

str=$(task add project:考研 +英语 depends:$id due:today+2d <++>)
id=$(echo $str | grep -o -E '[0-9]+')
