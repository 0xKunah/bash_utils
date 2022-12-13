<body>
	<header style="display: flex; align-items: center; justify-content: space-around">
		<h1>bash_utils</h1>
	</header>
	<h5>✅ This is not a 42 project, you can take it, even if you're a 42 student </h5>
	<p>bash_utils is a set of useful bash scripts (made for 42 computers, some features will therefore not be useful / usable elsewhere)</p>
	<h2>Table of content: </h2>
	<ul>
		<li><a href="#features">Features</a></li>
		<li><a href="#issues">Issues</a></li>
	</ul>
	<h2 id="features">Features</h2>
	<ul>
		<li><h3><a href="https://github.com/dbiguene/bash-utils/better_norminette.sh">better_norminette:</a></h3>
			<p>Runs norminette with a prettier output</p>
			<p>Example: <code>./better_norminette.sh -s *.c</code></p>
			<small>Idea is from <a targer="_blank" href="https://github.com/gd-harco/">gd-harco</a>, code is from me</small>
		</li>
		<li><h3><a href="https://github.com/dbiguene/bash-utils/easy_git.sh">easy_git:</a></h3>
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
		<li><h3><a href="https://github.com/dbiguene/bash-utils/make_autoload.sh">make_autoload:</a></h3>
			<p>Easier way to put all your source / header files in your makefile...</p>
			<h4>Flags: </h4>
			<p>Notice that all the following flags arent mandatory, using them will just prevent the script to ask you for branc name, repo url, remote name,...</p>
			<ul>
				<li><code>-srcs="src_dir" | --sources="src_dir"</code>: Set the sources directory</li>
				<li><code>-h="headers_dir" | --headers="headers_dir"</code>: Set the headers directory</li>
			</ul>
			<p>Example: <code>./make_autoload.sh -srcs="src/" -h="include/"</code> Will list and format all .c files of ./src/ and all .h files of ./include/ into ./output.txt</p>
		</li>
	</ul>
	<h2 id="issues">Issues</h2>
	<p>If you find a bug or encounter an issue using this funciton, feel free to open a issue, or a pull request if you know how to fix it</p>
</body>
