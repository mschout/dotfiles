function genstring --description "Generate random alphanumeric string"
    # Parse arguments
    set -l length 16
    if test (count $argv) -gt 0
        set length $argv[1]
    end

    # Validate input
    if not string match -qr '^[0-9]+$' $length
        echo "Error: Length must be a positive number" >&2
        return 1
    end

    if test $length -eq 0
        echo "Error: Length must be greater than 0" >&2
        return 1
    end

    # Generate the string
    cat /dev/urandom | tr -dc 'a-zA-Z0-9' | head -c $length
    echo  # Add newline
end
