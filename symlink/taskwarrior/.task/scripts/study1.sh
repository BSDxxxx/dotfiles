# 奖励
str=$(task add project:考研 +奖励             due:<++> <++>)
bonous_id=$(echo $str | grep -o -E '[0-9]+')

# 学习内容
str=$(task add project:考研 +高数             due:<++> <++>)
id=$(echo $str | grep -o -E '[0-9]+')
task $bonous_id modify depends:$id

str=$(task add project:考研 +高数 depends:$id due:<++> <++>)
id=$(echo $str | grep -o -E '[0-9]+')
task $bonous_id modify depends:$id

str=$(task add project:考研 +英语 depends:$id due:<++> <++>)
id=$(echo $str | grep -o -E '[0-9]+')
task $bonous_id modify depends:$id

str=$(task add project:考研 +英语 depends:$id due:<++> <++>)
id=$(echo $str | grep -o -E '[0-9]+')
task $bonous_id modify depends:$id
