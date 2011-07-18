#!/bin/bash

#######################################################
# generate backup repo
#######################################################
version="0.1"
backups_dir="/Volumes/VMARK/webservers/_backups"

#usage
# createBackup name path

repo_dir="$backups_dir/$1"


# copy content to backup file
cp -r $2 $repo_dir
cd $repo_dir

# initialize repo
git init

# commit current state
datestamp=$(date +"%Y-%m-%d")
timestamp=$(date +"%H:%M")

git add * 
git commit -am "Backup created on $datestamp at $timestamp."

git branch backup

