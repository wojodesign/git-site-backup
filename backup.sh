  #!/bin/bash

  #######################################################
  # git-sitebackup v0.1
  #######################################################

 

  #######################################################
  # Configuration
  #######################################################
 
  # Database connection information
  dbname=$1      # (e.g.: $dbname = "drupaldb")
  dbuser=$2      # (e.g.: $dbuser = "drupaluser")
  dbpass=$3      # (e.g.: $dbpass = "drupaldbPassword")
 
  # Website Files
  webrootdir=$4  # (e.g.: $webrootdir = "/home/user/public_html")

 
  #######################################################
  # Banner
  #######################################################
  echo -e "\n VMARK-sitebackup v0.1\n"
 
 
  #######################################################
  # sqldump database information
  #######################################################
  echo -e " .. sqldump'ing database:"
  echo -e "    user: $dbuser database: $dbname"
  cd $webrootdir
  mysqldump --password=$dbpass --user=$dbuser --skip-extended-insert $dbname > dbcontent.sql  
  echo -e "    done\n"
 
 
 
  #######################################################
  # Commit to Git Repo
  #######################################################
  echo -e " .. Committing to local git repository at $gitRepoBase"
  datestamp=$(date +"%Y-%m-%d")
  timestamp=$(date +"%H:%M")
  cd $webrootdir
  git add *
  git commit -am "Backup created on $datestamp at $timestamp."
  echo -e "    done\n"
 
 
  #######################################################
  # Push out to Master
  #######################################################
  echo -e " .. Pushing backup to Master repo"
  git push origin master
  echo -e "    done\n"


 
  #######################################################
  # Cleanup
  #######################################################
  echo -e " .. Cleaning up"
  git gc
  echo -e "    done\n"


 
  #######################################################
  # Exit banner
  #######################################################
  echo -e " .. Full site backup complete\n"