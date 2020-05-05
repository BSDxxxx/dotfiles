# 奖励
str=$(task add project:考研 +奖励             due:<++> <++>)
bonous_id=$(echo $str | grep -o -E '[0-9]+')

# 学习内容
str=$(task add project:考研 +政治             due:<++> <++>)
id =$(echo $str | grep -o -E '[0-9]+')
task $bonous_id modify depends:$id

str=$(task add project:考研 +政治 depends:$id due:<++> <++>)
id =$(echo $str | grep -o -E '[0-9]+')
task $bonous_id modify depends:$id

str=$(task add project:考研 +专业 depends:$id due:<++> <++>)
id =$(echo $str | grep -o -E '[0-9]+')
task $bonous_id modify depends:$id

str=$(task add project:考研 +专业 depends:$id due:<++> <++>)
id =$(echo $str | grep -o -E '[0-9]+')
task $bonous_id modify depends:$id
