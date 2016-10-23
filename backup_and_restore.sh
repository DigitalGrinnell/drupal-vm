# Use rootstalk_create_backup from your HOST machine to backup a copy of the existing default database and files.
alias vm_create_backup="ssh vagrant@rootstalk.dev \"cd /var/www/drupal/web/sites/default;drush ard default --no-core --destination='./rootstalk.tar.gz' --overwrite\""  
alias rsync_file_message="printf \"Transfering backup to '/Volumes/RS' directory on your local machine: \n\""
alias backup_complete_message="printf \"File backup complete!!! These are the contents of the flash drive...\n\""
alias vm_pull_to_RS="rsync_file_message;rsync root@rootstalk.dev:/var/www/drupal/web/rootstalk.tar.gz /Volumes/RS/;backup_complete_message;ls /Volumes/RS;"
alias vm_save_to_shared="ssh root@rootstalk.dev \"cp /var/www/drupal/web/rootstalk.tar.gz /var/www/drupalvm\""
alias rootstalk_vm_backup="vm_create_backup;vm_save_to_shared;vm_pull_to_RS"

# Use rootstalk_vm_restore from your HOST machine to restore a copy fo the default database and files.
alias vm_push_to_vm="rsync ./rootstalk.tar.gz vagrant@rootstalk.dev:/var/www/drupal/web/"
alias vm_restore_backup="ssh root@rootstalk.dev \"cd /var/www/drupal; drush arr -v web/rootstalk.tar.gz default --overwrite --tar-options='vz';cd web/sites/default; drush cr all\""
alias rootstalk_vm_restore="vm_push_to_vm;vm_restore_backup"
