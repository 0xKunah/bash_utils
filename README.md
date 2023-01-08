<body>
	<header style="display: flex; align-items: center; justify-content: space-around">
		<h1>bash_utils</h1>
	</header>
	<h5>✅ This is not a 42 project, you can take it, even if you're a 42 student </h5>
	<p>bash_utils is a set of useful bash scripts (made for 42 computers, some features will therefore not be useful / usable elsewhere)</p>
	<h2>Table of content: </h2>
	<ul>
		<li><a href="#installation">Installation</a></li>
		<li><a href="#features">Features</a></li>
		<li><a href="#issues">Issues</a></li>
	</ul>
	<h2 id="installation">Installation</h2>
	<pre>git clone https://github.com/dbiguene/bash_utils.git
bash ./bash_utils/installer.sh</pre>
	<h2 id="features">Features</h2>
	<ul>
		<li><h3><a href="https://github.com/dbiguene/bash_utils/blob/main/better_norminette.sh">better_norminette:</a></h3>
			<p>Runs norminette with a prettier output</p>
			<p>Example: <code>./better_norminette.sh -s *.c</code></p>
			<small>Idea is from <a targer="_blank" href="https://github.com/gd-harco/">gd-harco</a>, code is from me</small>
		</li>
		<li><h3><a href="https://github.com/dbiguene/bash_utils/blob/main/easy_git.sh">easy_git:</a></h3>
			<p>Easier way to manage your repo, add files, commit...</p>
			<h4>Flags: </h4>
			<p>Notice that all the following flags arent mandatory, using them will just prevent the script to ask you for branc name, repo url, remote name,...</p>
			<ul>
				<li><code>-s | --silent</code>: Hide all git console messages</li>
				<li><code>-af="files" | --addfiles="files"</code>: Files to add on the repo</li>
				<li><code>-c="message" | --commit="message"</code>: Commit message</li>
				<li><code>-r="remote_name" | --remote="remote_name"</code>: Set the remote name</li>
				<li><code>-url="repo_url" | --repo_url="repo_url"</code>: Set the repo url</li>
				<li><code>-b="branch_name" | --branch="branch_name"</code>: Set the branch name</li>
			</ul>
			<p>Example: <code>./easy_git.sh -s -af="." -c="Commit message" -url="https://github.com/dbiguene/bash_utils.git" -r="origin" -b="main"</code> Will init a repo, checkout to branch "main", add "origin" remote on "https://github.com/dbiguene/bash_utils", add all files, and commit "Commit message"</p>
		</li>
		<li><h3><a href="https://github.com/dbiguene/bash_utils/blob/main/make_autoload.sh">make_autoload:</a></h3>
			<p>Easier way to load your dependencies on your makefile</p>
			<h4>Flags: </h4>
			<p>Notice that all the following flags arent mandatory, using them will just prevent the script to ask you for branc name, repo url, remote name,...</p>
			<ul>
				<li><code>-srcs="src_dir" | --sources="src_dir"</code>: Set srcs dir</li>
				<li><code>-h="headers_dir" | --headers="headers_dir"</code>: Set headers dir</li>
			</ul>
			<p>Example: <code>./make_autoload -srcs="src/" -h="include/"</code> Will list and format all .c files into src/ dir, and all .h files into include/ dir</p>
		</li>
		<li><h3><a href="https://github.com/dbiguene/bash_utils/blob/main/templater.sh">templater:</a></h3>
			<p>Easier way to start your projects, with a prebuilt makefile and a clean structure, can handle libs too</p>
			<h4>Flags: </h4>
			<p>Notice that all the following flags arent mandatory, using them will just prevent the script to ask you for branc name, repo url, remote name,...</p>
			<ul>
				<li><code>-l="libft_url" | --libft="libft_url"</code>: Creates a project using your libft</li>
				<li><code>-mlx | --minilibx</code>: Creates a project using mlx</li>
				<li><code>-p="project_path" | --path="project_path"</code>: Creates the project to the given path</li>
				<li><code>-n="project_name" | --name="project_name"</code>: Set the project name</li>
			</ul>
			<p>Example: <code>./templater -n="so_long" -p="." -mlx</code> Will create a project named "so_long" to "./" using mlx</p>
		</li>
	</ul>
	<h2 id="issues">Issues</h2>
	<p>If you find a bug or encounter an issue using this funciton, feel free to open a issue, or a pull request if you know how to fix it</p>
</body>
