function j() {
    local SEARCHDIRS=${J_SEARCHDIRS:-$HOME}

    if [ $# -lt 1 ]; then
        echo "j - Jump to the directory of the named project"
        echo
        echo "Usage: j <name>"
        echo
        return 1
    fi

    DIR=($(find ${(z)SEARCHDIRS//:/ } -depth 1 -name "*$@*" -type d))
    case ${#DIR[@]} in
    0)
        return
        ;;
    1)
        # Do nothing - we know the dir we want now.
        ;;
    *)
        CANDIDATE=""
        for CHOICE in ${DIR[@]}; do
            if [ "${CHOICE##*/}" = "$@" ]; then
                if [ -n "$CANDIDATE" ]; then
                    break 2
                fi
                CANDIDATE=$CHOICE
            fi
        done

        if [ -n "$CANDIDATE" ]; then
            # One exact match - proceed.
            DIR=$CANDIDATE
        else
            # Multiple choices, but no exact match - prompt.
            select CHOICE in ${DIR[@]}; do
                DIR=$CHOICE
                break
            done
        fi
        ;;
    esac

    echo "--> $DIR"
    cd $DIR
}
