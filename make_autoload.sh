# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    make_autoload.sh                                   :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: dbiguene <dbiguene@student.42lyon.fr>      +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/12/13 18:26:54 by dbiguene          #+#    #+#              #
#    Updated: 2022/12/13 20:06:40 by dbiguene         ###   ########lyon.fr    #
#                                                                              #
# **************************************************************************** #

# Colors for prettier messages
cyan="\033[1;36m"
green="\033[1;32m"

# Parse flags
for i in "$@"; do
  case $i in
	# Srcs flag (Prevent the script to ask for "Srcs dir: ", automatically do it)
    -srcs=*|--sources=*)
      srcs_dir="${i#*=}"
      shift
      ;;
	# Headers flag (Prevent the script to ask for "Headers dir: ", automatically do it)
    -h=*|--headers=*)
      headers_dir="${i#*=}"
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

# Print with colors
colored_printf()
{
	printf "${1}$2\033[1;00m" $3
}

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


# If srcs flag has not been used
if [ "$srcs" = "" ]; then
	# Ask if user wants to change default srcs dir
	ask "Current sources dir is default (src/), do you want to change it ?"
	if [ $ask_choice = 1 ]; then
		# Ask for new dir
		colored_printf $cyan "Path to your sources dir: "
		read srcs_dir
	else
		# Else, set default dir
		srcs_dir="src/"
	fi
fi

# Then get all .c files into srcs_dir
echo "Sources list: \n" > output.txt
find $srcs_dir -name "*.c" | awk '{
	if (NR % 2 == 0)
			printf "\t%s", $1
	else if (NR > 1)
		printf "\t%s\t\\\n", $1

}' >> output.txt

# If headers flag has not been used
if [ "$headers" = "" ]; then
	# Ask if user wants to change default srcs dir
	ask "Current headers dir is default (include/), do you want to change it ?"
	if [ $ask_choice = 1 ]; then
		# Ask for new dir
		colored_printf $cyan "Path to your headers dir: "
		read headers_dir
	else
		# Else, set default dir
		headers_dir="include/"
	fi
fi

echo "\n\nHeaders list: \n" >> output.txt
find $headers_dir -name "*.h" | awk '{
	if (NR % 2 == 0)
			printf "\t%s", $1
	else if (NR > 1)
		printf "\t%s\t\\\n", $1

}' >> output.txt

colored_printf $green "Successfully loaded all files to $(pwd)/output.txt\n"
