source ~/.bash_profile
if ! cat ~/.bash_profile | grep -q "$1"; then
	echo "1"
	echo "export $1=$2" >> ~/.bash_profile && source ~/.bash_profile
elif ! cat ~/.bash_profile | grep -q "$2"; then
	echo "2"
	sed -i "s/export $1*=.*/export massa_wallet_address=$2/" ~/.bash_profile
fi
source ~/.bash_profile
