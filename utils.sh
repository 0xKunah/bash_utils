# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    utils.sh                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: dbiguene <dbiguene@student.42lyon.fr>      +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/12/14 13:30:56 by dbiguene          #+#    #+#              #
#    Updated: 2022/12/14 13:42:44 by dbiguene         ###   ########lyon.fr    #
#                                                                              #
# **************************************************************************** #

#!/bin/sh

# Colors for prettier messages
cyan="\033[1;36m"
green="\033[1;32m"
yellow="\033[1;33m"
red="\033[1;31m"

# Ask user for a [y/n] choice
ask_choice=0
ask()
{
	colored_printf $cyan "$1 [y/n]: "
	read choice
	# If choice is "y" or "n", the variable to 1 or 0
	if [ "$choice" = "y" ]; then
		ask_choice=1
	elif [ "$choice" = "n" ]; then
		ask_choice=0
	# Else, ask again
	else
		ask "$1"
	fi
}

# Print with colors
colored_printf()
{
	printf "${1}$2\033[1;00m" $3
}
