# Timesfhit CLI Cheat Sheet

## Setup

```bash
sudo cp ~/.config/timeshift/timeshift.json /etc/timeshift/timeshift.json
```

## Devices & Status

- **View all existing snapshots with:**
  `sudo timeshift --list`
- **Show available backup devices:**
  `sudo timeshift --list-devices`

## Creating Snapshots

- **Create a snapshot with a description:**
  `sudo timeshift --create --comments "description"`
- **Create a daily-tagged snapshot:**
  `sudo timeshift --create --tags D`

## Restoring Snapshots

- **Interactive restore (prompts for snapshot selection):**
  `sudo timeshift --restore`
- **Non-interactive restore of a specific snapshot:**
  `sudo timeshift --restore --snapshot 'NAME' --yes`
- **Restore to a different device (useful when migrating or repairing a system from a live USB):**
  `sudo timeshift --restore --snapshot 'NAME' --target /dev/sdx1 --grub /dev/sdx`

## Deleting Snapshots

- **Delete a specific snapshot:**
  `sudo timeshift --delete --snapshot 'NAME'`
- **Delete all snapshots:**
  `sudo timeshift --delete-all`
