# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    better_norminette.sh                               :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: dbiguene <dbiguene@student.42lyon.fr>      +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/12/12 20:13:39 by dbiguene          #+#    #+#              #
#    Updated: 2022/12/14 13:44:43 by dbiguene         ###   ########lyon.fr    #
#                                                                              #
# **************************************************************************** #

#!/bin/sh

# Load extern functions
source $(dirname "${BASH_SOURCE[0]}")/utils.sh

filename="better_norminette.log"
silent=0
files="*"

if [ "$1" = "--silent" ] || [ "$1" = "-s" ]; then
	silent=1
	files=$2
elif [ "$2" = "--silent" ] || [ "$2" = "-s" ]; then
	silent=1
	files=$1
else
	files=$1
fi

norminette $files | grep "Error" | awk '{
	if ($1 == "Error:") {
		printf "\tLine %d: \t", $4;
		sub( "^(.*)\t", "", $0 )
		print $0;
	} else print $1
}' > $filename

if [ $(cat $filename | wc -l) -eq 0 ]; then
	colored_printf $green "0 Norminette errors found !\n"
	rm -f $filename
else {
	if [ $silent -eq 1 ]; then
		norm_errors=$(norminette $files | grep "Error:" | wc -l)
		color=$green
		if [ $norm_errors -gt 60 ]; then
			color=$red
		elif [ $norm_errors -gt 30 ]; then
			color=$yellow
		fi
		colored_printf $color "$norm_errors\033[1;00m Norminette errors found, see \033[1;34m$(pwd)/$filename\033[1;00m for more infos." 
	else
		cat $filename | awk '{
			if ($1 == "Line") {
				printf "\n\t\033[1;36mLine ";
				sub($1, "", $0)
				printf "%d\033[1;00m", $1
				sub($1, "", $0)
				printf $0
			} else printf "\n\033[1;34m%s", $1
		}'
		printf "\n"
	fi
}
fi
