status --is-interactive || return

function capi
    if ! type -q http
        echo "http command is not available"
        return
    end

    if test -z "$COURTAPI_APP_ID"
        echo "COURTAPI_APP_ID is not set"
        return
    end

    if test -z "$COURTAPI_APP_KEY"
        echo "COURTAPI_APP_KEY is not set"
        return
    end

    http --auth $COURTAPI_APP_ID:$COURTAPI_APP_KEY $argv
end
