#!/bin/bash

csd=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
# hack app
if [[ "$csd" == *.app/Contents/Resources ]]
then
    parentdir="$(dirname "$(pwd)")"
    parentdir="$(dirname "$parentdir")"
    csd="$(dirname "$parentdir")"
else
    csd=$csd
fi
# hack app done
package=$(basename "$csd")
cd $csd


if [[ -z $(git status -s) ]]
then
    echo "Tree is clean, no need to do anything, exiting..."
    exit
else
cd $csd
git add -A 
git commit -m 'update' 
git push origin master 

fi