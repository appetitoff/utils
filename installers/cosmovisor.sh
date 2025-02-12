#!/bin/bash
# Default variables
function="install"

# Options
. <(wget -qO- https://raw.githubusercontent.com/SecorD0/utils/main/colors.sh) --
option_value(){ echo "$1" | sed -e 's%^--[^=]*=%%g; s%^-[^=]*=%%g'; }
while test $# -gt 0; do
	case "$1" in
	-h|--help)
		. <(wget -qO- https://raw.githubusercontent.com/SecorD0/utils/main/logo.sh)
		echo
		echo -e "${C_LGn}Functionality${RES}: the script installs or uninstalls Cosmovisor"
		echo
		echo -e "${C_LGn}Usage${RES}: script ${C_LGn}[OPTIONS]${RES}"
		echo
		echo -e "${C_LGn}Options${RES}:"
		echo -e "  -h,  --help             show the help page"
		echo -e "  -un, --uninstall        uninstall Cosmovisor"
		echo
		echo -e "You can use either \"=\" or \" \" as an option and value ${C_LGn}delimiter${RES}"
		echo
		echo -e "${C_LGn}Useful URLs${RES}:"
		echo -e "https://github.com/SecorD0/utils/blob/main/installers/golang.sh - script URL"
		echo -e "https://t.me/OnePackage — noderun and tech community"
		echo -e "https://learning.1package.io — guides and articles"
		echo -e "https://teletype.in/@letskynode — guides and articles"
		echo
		return 0 2>/dev/null; exit 0
		;;
	-u|-un|--uninstall)
		function="uninstall"
		shift
		;;
	*|--)
		break
		;;
	esac
done

# Functions
install() {
	echo -e "${C_LGn}Cosmovisor installation...${RES}"
	sudo apt update
	sudo apt upgrade -y
	sudo apt install wget git build-essential make jq -y
	. <(wget -qO- https://raw.githubusercontent.com/SecorD0/utils/main/installers/golang.sh)
	cd
	git clone https://github.com/cosmos/cosmos-sdk
	cd cosmos-sdk/
	local cosmovisor_version=`git tag -l "cosmovisor*" | tail -n1`
	git checkout $cosmovisor_version
	make cosmovisor
	mv cosmovisor/cosmovisor /usr/bin
	cd
	rm -rf $HOME/cosmos-sdk/
}
uninstall() {
	echo -e "${C_LGn}Cosmovisor uninstalling...${RES}"
	rm -rf $HOME/cosmos-sdk/ `which cosmovisor`
}

# Actions
$function
echo -e "${C_LGn}Done!${RES}"
