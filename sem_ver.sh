#!/usr/bin/env sh

IFS='.' read -ra ver <<< "$1"
[[ "${#ver[@]}" -ne 3 ]] && echo "Invalid semver string" && exit 1
[[ "$#" -eq 1 ]] && level='release' || level=$2

release=${ver[2]}
minor=${ver[1]}
major=${ver[0]}

case $level in
    release)
        release=$((release+1))
    ;;
    minor)
        release=0
        minor=$((minor+1))
    ;;
    major)
        release=0
        minor=0
        major=$((major+1))
    ;;
    *)
        echo "Invalid level passed"
        exit 2
esac
echo "$major.$minor.$release"