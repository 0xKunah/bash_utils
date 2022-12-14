# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    installer.sh                                       :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: dbiguene <dbiguene@student.42lyon.fr>      +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/12/14 12:03:36 by dbiguene          #+#    #+#              #
#    Updated: 2022/12/14 13:51:31 by dbiguene         ###   ########lyon.fr    #
#                                                                              #
# **************************************************************************** #

#!/bin/sh

# Load extern functions
source $(dirname "${BASH_SOURCE[0]}")/utils.sh

# Default path (can be changed with -p flag)
path="/Users/$(who | grep 'console' | awk '{print $1}')/bash_utils"

# Parse flags
for i in "$@"; do
  case $i in
	# All flag (Will automatically install all scripts)
    -a|--all)
      all=1
      shift
      ;;
	# Path flag (Change the path where the script will install other scripts)
    -p=*|--path=*)
      path="${i#*=}"
      shift
      ;;
	# All unsupported flags
    -*|--*)
      echo "Unknown option $i"
      exit 1
      ;;
    *)
      ;;
  esac
done

# Find all scripts in the same dir that installer.sh
scripts=$(find $(dirname "${BASH_SOURCE[0]}") -name "*.sh")

# Create directory that will contain the scripts
mkdir -p $path

# For each script
for script in $scripts; do
	# If the script is "utils.sh", install it without alias and without asking user (this script is mandatory for the other ones)
	if [ $script = "$(dirname ${BASH_SOURCE[0]})/utils.sh" ]; then
		cp $script $path
	# Check that the script is not the installer (this one)
	elif [ $script != "$(dirname ${BASH_SOURCE[0]})/installer.sh" ]; then
		# Ask user if this scripts has to be installed or no
		ask "Do you want to install $script ?"
		# If choice is 1 (means yes), install the script
		if [ $ask_choice = 1 ]; then
			# Copy the script to the given path
			cp $script $path
			# Ask user for alias name
			colored_printf $cyan "Alias name for %s: " $script
			read alias_name
			# Create alias
			echo "alias $alias_name=\"bash $path/$(echo $script | sed 's:.*/::')\"" >> ~/.zshrc
		fi
	fi
done

colored_printf $green "All scripts you chosen are successfully installed !\n"
