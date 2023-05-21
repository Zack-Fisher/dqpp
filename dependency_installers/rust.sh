function rust() {
    # Install Rust using rustup
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

    # Add cargo to PATH
    source $HOME/.cargo/env

    # Install Rocket using cargo
    cargo install rocket

    # Check if Rocket was installed successfully
    if ! command -v rocket >/dev/null; then
        echo "Error: Rocket installation failed."
        exit 1
    fi

    # Output Rocket version
    echo "Rocket version: $(rocket --version)"
}