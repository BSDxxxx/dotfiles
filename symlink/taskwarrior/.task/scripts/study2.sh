str=$(task add project:考研 +政治             <++>)
id =$(echo $str | grep -o -E '[0-9]+')
str=$(task add project:考研 +政治 depends:$id <++>)
id =$(echo $str | grep -o -E '[0-9]+')
str=$(task add project:考研 +专业 depends:$id <++>)
id =$(echo $str | grep -o -E '[0-9]+'`
str=$(task add project:考研 +专业 depends:$id <++>)
