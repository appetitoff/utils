# $1 - variable name
# $2 - variable value
# $3 - is it a command? (true, false)
# $4 - replase it to $1
#!/bin/bash
if [ "$2" = "" ]; then
	read -p $'Enter the value: \e[40m\e[92m' value
	echo -n -e '\e[0m'
else
	value=$2
fi
if [ "$3" = "true" ]; then
	is_command="alias"
else
	is_command="export"
fi
if [ -n "$4" ]; then
	sed -i "s/$4/$1/" ~/.bash_profile
. ~/.bash_profile
fi
if ! cat ~/.bash_profile | grep -q "$1"; then
	echo "$is_command $1=\"$value\"" >> ~/.bash_profile
elif ! cat ~/.bash_profile | grep -q "$1=\"$value\""; then
	sed -i "s/^$iscommand $1*=.*/$iscommand $1=\"$value\"/" ~/.bash_profile
elif cat ~/.bash_profile | grep -q "$1=\"$value\""; then
	sed -i "s/^.*$1*=.*/$is_command $1=\"$value\"/" ~/.bash_profile
fi
. ~/.bash_profile
