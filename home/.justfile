_default:
    @just --list --justfile {{ justfile() }}

init:
    restic init -r rclone:idrive:backups/dalinux --password-command "pass show restic/dalinux"

backup:
    restic backup -r rclone:idrive:backups/dalinux --files-from ~/.config/restic/includes.txt --exclude-file ~/.config/restic/excludes.txt --password-command "pass show restic/dalinux"

restore snapshot:
    restic restore {{ snapshot }} -r rclone:idrive:backups/dalinux --password-command "pass show restic/dalinux" --target /tmp/backup-restore
    @echo "backup restored at /tmp/backup-restore"

snapshots:
    restic snapshots -r rclone:idrive:backups/dalinux --password-command "pass show restic/dalinux"

forget snapshot:
    restic forget {{ snapshot }} -r rclone:idrive:backups/dalinux --password-command "pass show restic/dalinux"
