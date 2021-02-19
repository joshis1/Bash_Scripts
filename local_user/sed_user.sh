#!/bin/bash

# SED - Stream Editor.

# sed - usage.
#  substitute.
#  remove lines.
#  append lines.
#  insert text before certain lines.


# sed 's/''/''/flag'

# common usage sed - find and replace.

# type -a sed

# man sed | less

# sed - stream editor for filtering and transforming.

# sed [OPTION]... {scripting option} [OPTION File]...

echo 'Dwiht is the assistant regional manager.' > manager.txt

cat manager.txt

sed 's/assistant/assistant to the/g' manager.txt

# sed is not altering the contents of the file.

cat manager.txt

rm -f manager.txt

echo 'I love my wife.' > love.txt
cat love.txt

sed 's/my wife/sed/' love.txt

echo 'i means ignore case'
sed 's/MY WIFE/sed/i' love.txt

echo 'This is line 2.' >> love.txt
cat love.txt

echo 'I love my wife all of my heart.' >> love.txt

sed 's/my wife/sed/' love.txt

# sed 's/search-pattern/replacement-string/flags'

echo 'I love my wife and my wife loes me. Also, my wife loves the cat.' >> love.txt

cat love.txt

echo 'If you want to replace the second occurence then use flag 2 i.e. s/my wife/2 '

echo 'If you want to replace the third occurence then use flag 3 i.e. s/my wife/3 '

# saving the output.

echo 'in place editing - i'

sed -i.bak 's/my wife/sed/' love.txt

# original file is saved as love.txt.bak

sed 's/love/like/gw like.txt' love.txt

cat like.txt


echo 'replace /home/shreyas with /export/jshreyas'
echo 'using escape character'

echo '/home/shreyas' | sed 's/\/home\/shreyas/\/export\/jshreyas/'


echo 'sed is start use any delimiter you want'
echo '/home/shreyas' | sed 's#/home/shreyas#/export/jshreyas#'

# delete some line using sed.

echo 'delete This is line 2 using sed from love.txt'

echo 'flag d in sed means delete'
sed '/This/d' love.txt

echo '#User to run service as.' > config 
echo 'User apache' >> config 
echo >> config 
echo '#Group to run service as .' >> config 

cat config

echo 'delete the comment line that is which starts with #'
sed '/^#/d' config 

echo 'delete blank lines'
sed '/^$/d' config

echo 'combine sed command using semicolon'

sed '/^#/d; /^$/d' config 

# replace apache with httpd

sed '/^#/d; /^$/d; s/apache/httpd/' config

echo 'combine sed command using -e option'

sed -e '/^#/d' -e '/^$/d' -e 's/apache/using e option/' config

echo 'creating sed script and then running that script'
echo '/^#/d' > script.sed
echo '/^$/d' >> script.sed
echo 's/apache/scriptd/' >> script.sed

cat script.sed

echo 'using -f option to run the sed script on config'
sed -f script.sed config

# Address specified.

echo 'specify address in the sed command'
echo 'using address i.e. line 2'
sed '2 s/apache/httpd/' config

# Only on the line starting with Group
echo 'Only on the line having the word group'
# 'Basically using regular expression we are specifying that we want to change apache to httpd only on the line having the word Group'
sed '/Group/ s/apache/httpd/' config


echo 'Only from line 1 to 4 do the find and replace'
sed '1,4 s/run/execute/' config


echo 'starting range from #User to the blank line - replace run with execute'
sed '/#User/,/^$/  s/run/execute/' config

rm -f like.txt love.txt love.txt.bak config








