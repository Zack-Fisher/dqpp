function php() {
	# Update package lists
    sudo apt-get update

    # Install PHP and necessary extensions
    # extensions are binaries that add functionality to PHP itself, not packages. they're different.
    sudo apt-get install -y php php-cli php-fpm php-mysql php-zip php-gd php-mbstring php-curl php-xml

    # Install Composer
    sudo apt install composer
    composer global require laravel/installer
    composer global install laravel

    # Add Composer to PATH, so we can actually run laravel.
    echo 'export PATH="$HOME/.config/composer/vendor/bin:$PATH"' >> ~/.bashrc

    cd laravel_app
    # install dependencies for the specific project.
    composer install
    cd ..

    # Install MySQL (optional, adjust if you prefer a different database)
    sudo apt-get install -y mysql-server

    # Output PHP and Composer versions
    echo "PHP version: $(php --version | grep PHP | awk '{print $2}')"
    echo "Composer version: $(composer --version | grep Composer | awk '{print $3}')"
}
