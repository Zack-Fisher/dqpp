function ruby() {
	## RUBY
	# Update package lists
	sudo apt-get update

	# Install essential dependencies
	sudo apt-get install -y curl gpg build-essential libssl-dev libreadline-dev zlib1g-dev libsqlite3-dev

	# Install Node.js for JavaScript runtime
	curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
	sudo apt-get install -y nodejs

	# Install Ruby using rbenv
	git clone https://github.com/rbenv/rbenv.git ~/.rbenv
	echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
	echo 'eval "$(rbenv init -)"' >> ~/.bashrc
	source ~/.bashrc

	git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
	echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc
	source ~/.bashrc

	rbenv install 3.0.1
	rbenv global 3.0.1

	# Install Bundler and Rails
	gem install bundler
	gem install rails

	# Install PostgreSQL (optional, if you prefer a different database, adjust accordingly)
	sudo apt-get install -y postgresql libpq-dev

	# Configure PostgreSQL (optional)
	sudo -u postgres createuser --superuser $USER
	createdb

	# Install Yarn package manager
	curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
	echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
	sudo apt-get update
	sudo apt-get install -y yarn

	# Output versions for verification
	echo "Ruby version: $(ruby --version)"
	echo "Rails version: $(rails --version)"
	echo "Node.js version: $(node --version)"
	echo "Yarn version: $(yarn --version)"
}
