function backup {
	if [ -z $1 ]; then
		user=$(whoami)
	elif [ ! -d "/home/$1" ]; then
		echo "requested $1 user home directory doesnt exist"
		exit 1
	else
		user=$1
	fi
	input=/home/$user
	output=/home-backup/${user}_home_$(date +%Y-%m-%d_%H%M%S).tar

	#function gives total no of files in a directory
	function total_files {
		find $1 -type f | wc -l
	}
	#function gves no of sub directories for a given directory
	function total_directories {
		find $1 -type d | wc -l
	}
	#find the lines ending with folder i.e. ending with (/) $ means end of string
	function total_archived_directories {
		tar -tzf $1 | grep -c '/$'
	}
	function total_archived_files {
		tar -tzf $1 | grep -vc '/$'
	}
	#cd /home-backup/
	sudo tar -zvcf $output $input 2>&1 | grep -v "leading"
	#no of source and dest files and directories
	src_files=$(total_files $input)
	src_directories=$(total_directories $input)
	arc_files=$(total_archived_files $output)
	arc_directories=$(total_archived_directories $output)
	echo ".......... $user ..........."
	echo -n "Files count : "
	total_files $input
	echo -n "directories count : "
	total_directories $input
	echo "files archived: $arc_files "
	echo "directories archived: $arc_directories"

	if [ $src_files -eq $arc_files ]; then
		echo "backup of $input completed!, HERE ARE DETAILS OF OUTPUT BACKUP FILE"
		ls -l $output
	else
		echo "Backup of $input failed"
	fi
}

for directory in $*; do
	backup $directory
	let all=$all+$arc_files+$arc_directories
done
echo "Total FILES AND DIRECTORIES: $all"
