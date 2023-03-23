#!/bin/bash
#inputs destinations of files to be copied
echo "Enter Directory of .md Files: "
read src_dir
echo "Enter New Destination Directory: "
read new_dir

#declaring Array and counter
declare -a md_files=();
declare -a md_path=();
counter=0

# Loop through all files in the directory and its subdirectories with .md file extension
while IFS= read -r -d '' file_path; do
    # Get the dir path of each .md file
    md_path+=("$file_path")
    # Get the base filename without the directory path
    filename=$(basename "$file_path")
    
    # Add the filename to the array
    md_files+=("$filename")
done < <(find "$src_dir" -name '*.md' -type f -print0)

# Print the array to verify the contents
echo "The following .md files were found in the directory and its subdirectories:"
printf '%s\n' "${md_files[@]}"
printf '%s\n' "${md_path[@]}"

#Iterating through array
for (( i=0; i < ${#md_files[@]}; i++)); do
        #check is file exists in the new directory
        if [ -f "$new_dir/${md_files[$i]}" ] ; then
		echo "Checking if '${md_files[$i]}' is present in '$new_dir'"
		((++counter))
		`cp $md_path $new_dir/${counter}_${md_files[i]}`
		if [ -f "$new_dir/${counter}_${md_files[i]}" ]; then
			echo -e "The file '${md_files}' was successfully copied into '$new_dir' with the name '${counter}_${md_files[i]}'\n"
		else
			echo -e "There was a problem copying ${md_files[i]} in the directory '$new_dir'\n"
		fi
	else
		echo -e "\nChecking if '${md_files[i]} is present in $new_dir: "
		`cp $md_path $new_dir/${md_files[i]}`
		if [ -f "$new_dir/${md_files[i]}" ]; then
			echo -e "The file '${md_files[i]}' was successfully moved into '$new_dir'\n"
		else
			echo -e "There was a problem moving ${md_files[i]} in the directory '$new_dir'\n"
		fi
	fi
done
      
