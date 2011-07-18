  #!/bin/bash

  #######################################################
  # git-sitebackup 
  #######################################################
  version = "0.1"
 
  #######################################################
  # Banner
  #######################################################
  echo -e "\n git-sitebackup $version \n"

  #######################################################
  # Grand Central... direct to the correct actions
  # based on number of inputs
  #######################################################


  # only filepath present: do not backup dB and do not push to remote
  if[$# -eq 1 ]; then
	
   
	
	  dir = $1
	  commit_changes $dir
	
	
	
  # only filepath & remote branch present: do not backup dB, push to remote
  elif[$# -eq 2 ]; then
	
	dir = $1
	branch = $2
	
	commit_changes $dir
	push_to_remote $dir $branch
	
	
  # filepath and dB info present: backup both, do not push to remote
  elif[$# -eq 4 ]; then
	
	dir = $1
	dbname = $2
	dbuser = $3
	dbpass = $4
	
	dump_db $dir $dbname $dbuser $dbpass
	commit_changes $dir 
		
  # all arguments present: backup files and db, push to remote
  elif[$# -eq 5 ]; then
    dir = $1
	dbname = $2
	dbuser = $3
	dbpass = $4
	branch = $5

	dump_db $dir $dbname $dbuser $dbpass
	commit_changes $dir 
	push_to_remote $dir $branch

  fi
	
  #cleanup and exit
  cleanup
	
	
 
  #######################################################
  # sqldump database information
  #######################################################
  function dump_db {
    dir = $1
	dbname = $2
	dbuser = $3
	dbpass = $4
   
    echo -e " .. sqldump'ing database:"
    echo -e "    user: $dbuser database: $dbname"
    cd $dir
    mysqldump --password=$dbpass --user=$dbuser --skip-extended-insert $dbname > dbcontent.sql  
    echo -e "    done\n"
  }



  #######################################################
  # Commit to Git Repo
  #######################################################
  function commit_changes {
    dir = $1

    echo -e " .. Committing to local git repository at $dir"
	datestamp=$(date +"%Y-%m-%d")
	timestamp=$(date +"%H:%M")
	cd $dir
	git add *
	git commit -am "Backup created on $datestamp at $timestamp."
	echo -e "    done\n"
  }




  #######################################################
  # Push out to Master
  #######################################################
  function push_to_remote {
    dir = $1
    branch = $2

    echo -e " .. Pushing backup to $2 repo"
	git push origin $2
	echo -e "    done\n"
	
  }


  #######################################################
  # Cleanup
  #######################################################
  function cleanup {
    echo -e " .. Cleaning up"
    git gc
    echo -e "    done\n"


	# Exit banner
	echo -e " .. Full site backup complete\n"
  }

  

  #######################################################
  # Install 
  #######################################################  
  function install {

  }
 
 