# $1 - variable name
# $2 - variable value
# $3 - is it a command? (true, false)
# $4 - replase it to $1
if [ -n "$3" ]; then
	is_command="alias"
else
	is_command="export"
fi
if [ -n "$4" ]; then
	sed -i "s/$4/$1/" ~/.bash_profile
. ~/.bash_profile
fi
if ! cat ~/.bash_profile | grep -q "$1"; then
	echo "$is_command $1=\"$2\"" >> ~/.bash_profile
elif ! cat ~/.bash_profile | grep -q "$1=\"$2\""; then
	sed -i "s/$is_command $1*=.*/$is_command $1=\"$2\"/" ~/.bash_profile
fi
. ~/.bash_profile
