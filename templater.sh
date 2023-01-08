# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    templater.sh                                       :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: dbiguene <dbiguene@student.42lyon.fr>      +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/01/08 18:24:45 by dbiguene          #+#    #+#              #
#    Updated: 2023/01/08 20:24:49 by dbiguene         ###   ########lyon.fr    #
#                                                                              #
# **************************************************************************** #

#!/bin/sh

# Load extern functions
source $(dirname "${BASH_SOURCE[0]}")/utils.sh

# Parse flags
for i in "$@"; do
  case $i in
	# Libft flag (add libft to project)
    -l=*|--libft=*)
      libft="${i#*=}"
      shift
      ;;
	# MLX flag (add mlx to project)
    -mlx|--minilibx)
      mlx=1
      shift
      ;;
    # Path flag (set the path for the project)
    -p=*|--path=*)
      path="${i#*=}"
      shift
      ;;
    # Name flag (set the name of the project)
    -n=*|--name=*)
      name="${i#*=}"
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

# If name flag has not been set, ask for it
if [ "$name" = "" ]; then
    colored_printf $cyan "Enter the name of the project: "
    read name
fi

# If name flag has not been set, ask for it
if [ "$path" = "" ]; then
    colored_printf $cyan "Enter the path of the project: "
    read path
    if [ "$path" = "" ]; then
        path="."
    fi
fi

# If libft flag has not been set, ask for it
if [ "$libft" = "" ]; then
    ask "Do you want to add libft to the project?"
    if [ "$ask_choice" = "1" ]; then
        colored_printf $cyan "Enter the url of your libft: "
        read libft
    fi
fi

# If mlx flag has not been set, ask for it
if [ "$mlx" = "" ]; then
    ask "Do you want to add mlx to the project?"
    if [ "$ask_choice" = "1" ]; then
        mlx=1
    fi
fi

# Create the project folder
mkdir $path/$name

# Create the srcs folder
mkdir $path/$name/srcs

# Create the includes folder
mkdir $path/$name/includes

# Clone libft if needed
if [ "$libft" != "" ]; then
    git clone -q $libft $path/$name/libft
fi

# Clone mlx if needed
if [ "$mlx" != "" ]; then
    # If user is on linux, clone mlx_linux
    if [ "$(uname)" = "MINGW64_NT-10.0-22621" ]; then
        git clone -q https://github.com/42Paris/minilibx-linux $path/$name/mlx
    # Else if user is on macos, clone mlx_opengl
    elif [ "$(uname)" = "Darwin" ]; then
        git clone -q https://github.com/gd-harco/mlx_mac $path/$name/mlx
    # Else, OS is not supported
    else
        colored_printf $red "MLX Does not support your OS"
        exit 1
    fi
fi

# Create the Makefile

# First, download the template using curl
curl -s https://cdn.kunah.fr/makefile_template > $path/$name/Makefile

# Replace {{name}} with the name of the project in mt file
sed -i "s/{{name}}/$name/g" $path/$name/Makefile

# If libft is used in the project, replace {{libft_path}} with the path of the libft
if [ "$libft" != "" ]; then
    sed -i "s/{{libft_path}}/LIBFT            =   libft\/libft\.a/g" $path/$name/Makefile

    # Then replace {{libft_name}} with the name of the libft
    sed -i "s/{{libft_name}}/\${LIBFT}/g" $path/$name/Makefile

    # Then replace {{base_framework}} with the base framework
    sed -i "s/{{base_framework}}/FRAMEWORKS		=	-Llibft -lft/g" $path/$name/Makefile

    # Then replace {{libft_rule}} with the libft rule
    libft_rule="\${LIBFT}		:\n\
                        make -C libft\n\
                        @echo \"\\\033[0;32m [\${NAME}\/libft] : ✔️ Successfully built libft\033[1;36m \${@} !\\\033[0;32m\""
    sed -i "s/{{libft_rule}}/$libft_rule/g" $path/$name/Makefile
else
    # Else, remove the libft rule
    sed -i "s/{{libft_rule}}//g" $path/$name/Makefile

    # Then remove the libft path
    sed -i "s/{{libft_path}}//g" $path/$name/Makefile

    # Then remove the libft name
    sed -i "s/{{libft_name}}//g" $path/$name/Makefile
fi

# If mlx is used in the project, replace {{mlx_path}} with the path of the mlx
if [ "$mlx" != "" ]; then
    mlx='MLX              =   mlx\/libmlx\.a'
    sed -i "s/{{mlx_path}}/$mlx/g" $path/$name/Makefile

    # Then replace {{mlx_name}} with the name of the libft
    sed -i "s/{{mlx_name}}/\${MLX}/g" $path/$name/Makefile

    # Then replace {{mlx_rule}} with the mlx rule
    mlx_rule="\${MLX}		:\n\
                        make -C mlx\n\
                        @echo \"\\\033[0;32m [\${NAME}\/mlx] : ✔️ Successfully built mlx\033[1;36m \${@} !\\\033[0;32m\""
    sed -i "s/{{mlx_rule}}/$mlx_rule/g" $path/$name/Makefile

    # Then replace {{os_flags}} with the os flags
    os_flags="ifeq (\$(UNAME), Linux)\n\
FRAMEWORKS		+= -lXext -lX11 -lm -lz\n\
endif\n\
\n\
ifeq (\$(UNAME), Darwin)\n\
FRAMEWORKS		+=	-framework OpenGL -framework AppKit\n\
endif"

    sed -i "s/{{os_flags}}/$os_flags/g" $path/$name/Makefile
else
    # Else, replace {{os_flags}} with nothing
    sed -i "s/{{os_flags}}//g" $path/$name/Makefile

    # Then replace {{mlx_name}} with nothing
    sed -i "s/{{mlx_name}}//g" $path/$name/Makefile

    # Then replace {{mlx_rule}} with nothing
    sed -i "s/{{mlx_rule}}//g" $path/$name/Makefile

    # Then replace {{mlx_path}} with nothing
    sed -i "s/{{mlx_path}}//g" $path/$name/Makefile

fi

# Finally if libft or MLX is used, replace {{framework}} with the FRAMEWORKS variable
if [ "$mlx" = "" ] || [ "$libft" = "" ]; then
    sed -i "s/{{framework}}/\${FRAMEWORKS}/g" $path/$name/Makefile
else
    sed -i "s/{{framework}}//g" $path/$name/Makefile

    sed -i "s/{{base_framework}}//g" $path/$name/Makefile
fi

# Says that the project has been created
colored_printf $green "Project $name has been created in $path/$name !"