#!/bin/bash

usage () {
    cat <<END
This is how you should use this fct : ...
END
}

error () {
    echo "Error: $1"
    usage
    exit $2
} >&2

error "something bad" 3