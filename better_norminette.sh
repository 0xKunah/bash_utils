# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    better_norminette.sh                               :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: dbiguene <dbiguene@student.42lyon.fr>      +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/12/12 20:13:39 by dbiguene          #+#    #+#              #
#    Updated: 2022/12/12 22:33:54 by dbiguene         ###   ########lyon.fr    #
#                                                                              #
# **************************************************************************** #

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
	printf "\033[1;32m0 Norminette errors found !\033[1;00m\n"
	rm -f $filename
else {
	if [ $silent -eq 1 ]; then
		norm_errors=$(norminette $files | grep "Error:" | wc -l)
		color=32
		if [ $norm_errors -gt 60 ]; then
			color=31
		elif [ $norm_errors -gt 30 ]; then
			color=33
		fi
		printf "\033[1;%sm%d\033[1;00m Norminette errors found, see \033[1;34m%s/$filename\033[1;00m for more infos." $color $norm_errors $(pwd)
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
