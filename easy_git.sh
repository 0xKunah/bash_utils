# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    easy_git.sh                                        :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: dbiguene <dbiguene@student.42lyon.fr>      +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/12/13 14:20:01 by dbiguene          #+#    #+#              #
#    Updated: 2022/12/13 15:40:00 by dbiguene         ###   ########lyon.fr    #
#                                                                              #
# **************************************************************************** #

# Colors for prettier messages
cyan="\033[1;36m"
green="\033[1;32m"

# Parse flags
for i in "$@"; do
  case $i in
	# Silent flag (add "-q" to git commands)
    -s|--silent)
      git_flag="-q"
      shift
      ;;
	# Addfiles flag (Prevent the script to ask for "add files ?", automatically do it)
    -af=*|--addfiles=*)
      files="${i#*=}"
      shift
      ;;
	# Commit flag (Prevent the script to ask for "commit changes ?", automatically do it)
    -c=*|--commit=*)
      commit_message="${i#*=}"
      shift
      ;;
	# Repo url flag (Prevent the script to ask for "Type repo url :", automatically do it)
    -url=*|--repo_url=*)
      repo_url="${i#*=}"
      shift
      ;;
	# Remote name flag (Prevent the script to ask for "Type remote name :", automatically do it)
    -r=*|--remote=*)
      remote_name="${i#*=}"
      shift
      ;;
	# Branch name flag (Prevent the script to ask for "Type remote name :", automatically do it)
    -b=*|--branch=*)
      branch_name="${i#*=}"
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

# Init repo, and switch branch if needed
init_repo()
{
	colored_printf $cyan "Initializing repo...\n"
	git init $git_flag
	# Check if branch flag has been used
	if [ "$branch_name" = "" ]; then
		# If flag has not been used, ask for branch name
		ask "Repo is currently on branch \"master\", do you want to change ?"
		if [ $ask_choice = 1 ]; then
			colored_printf $cyan "New branch name: "
			read branch_name
		fi
	fi
	# Then check if user chosen not to change branch
	if [ "$branch_name" != "" ]; then
		# Then create the branch and go to
		git checkout -b $branch_name $git_flag
		colored_printf $green "Successfully switched to branch $branch_name !\n"
	fi
	colored_printf $green "Repo successfully initialized !\n"
}

# Add remote to repo
add_remote()
{
	# Check if flag remote has been used
	if [ "$remote_name" = "" ]; then
		colored_printf $cyan "Remote name: "
		read remote_name
	fi
	# Check if flag repo_url has been used
	if [ "$repo_url" = "" ]; then
		colored_printf $cyan "Repo url: "
		read repo_url
	fi
	git remote add $remote_name $repo_url
	colored_printf $green "Remote $remote_name successfully created on repo $repo_url !\n"
}

# If there is no initialized git repo on the directory
# Init the repo and add a remote
if [ $(find ./ -name ".git" | wc -l) = 0 ]; then
	init_repo
	add_remote
fi

# If flag addfiles hasn't been used
if [ "$files" = "" ]; then
	# Ask if user want to add files
	ask "Do you want to add files on this repo ?"
	if [ $ask_choice = 1 ]; then
		# If yes, ask which files should be added
		colored_printf $cyan "Which files do you want to add: "
		read files
	fi
fi

# Check if user chosen not to add files
if [ "$files" != "" ]; then
	# Then add files
	git add $files
	colored_printf $green "Successfully added $files to the repo !\n"
fi

# If flag addfiles hasn't been used
if [ "$commit_message" = "" ]; then
	# Ask if user want to commit changes
	ask "Do you want to commit these changes ?"
	if [ $ask_choice = 1 ]; then
		# If yes, ask for commit message
		colored_printf $cyan "Type your commit message: "
		read commit_message
	fi
fi

# Check if user chosen not to commit changes
if [ "$commit_message" != "" ]; then
	# Then commit changes
	git commit -m "$commit_message" $git_flag
	colored_printf $green "Successfully commited !\n"
fi
