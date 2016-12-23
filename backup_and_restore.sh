# Use 'rootstalk_site_backup' from your HOST machine to backup a copy of the existing default database and files.

alias vm_create_backup="ssh dguser@rootstalk.grinnell.edu \"drush @drupalvm ard default --yes --no-core --destination='/tmp/rootstalk.tar.gz' --overwrite\""  

alias rsync_file_message1="printf \"Transfering backup to the current directory on the host (your local machine)... \n\""
alias rsync_file_message2="printf \"Transfering backup to '/Volumes/ROOTSTALK' directory on your local machine... \n\""
alias no_ROOTSTALK_device="printf \"Attention: Mount a USB stick named ROOTSTALK and run 'save_backup_to_ROOTSTALK' if you wish to backup to a device. \n\""
alias backup_complete_message="printf \"File backup complete!!! The contents of the flash drive include: \n\""

alias vm_pull_to_host1="rsync_file_message1; rsync -aruvi dguser@rootstalk.grinnell.edu:/tmp/rootstalk.tar.gz . "

alias save_backup_to_ROOTSTALK="
  rsync_file_message2; 
  current_time=$(date '+%Y.%m.%d-%H-%M'); 
  echo \"  current_time is: \"$current_time
  new_name=\"rootstalk.tar.gz_\"${current_time};
  echo \"  new_name is: \"${new_name} 
  mv -f ./rootstalk.tar.gz ${new_name}
  rsync -aruvi ${new_name} /Volumes/ROOTSTALK/; 
  backup_complete_message; 
  ls /Volumes/ROOTSTALK;"

alias rootstalk_site_backup="
  vm_create_backup; 
  vm_pull_to_host1; 
  if [ -d \"/Volumes/ROOTSTALK\" ]; then
    save_backup_to_ROOTSTALK
  else
    no_ROOTSTALK_device
  fi"

# Use rootstalk_vm_restore from your HOST machine to restore a copy fo the default database and files.

alias vm_push_to_vm="rsync -aruvi ./rootstalk.tar.gz dguser@dgdevx.grinnell.edu:/var/www/html/drupal/"
alias vm_restore_backup="ssh dguser@rootstalk.grinnell.edu \"cd /var/www/html/drupal; drush arr -v rootstalk.tar.gz default --overwrite --tar-options='vz'; cd web/sites/default; drush cr all\""
alias rootstalk_vm_restore="vm_push_to_vm; vm_restore_backup"
