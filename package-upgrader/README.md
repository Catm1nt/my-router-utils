Package Upgrader
=======
OpenWRT's `opkg` doesn't have a subcommand for upgrading all packages. This script checks for latest versions of all installed packages and upgrade them. This is a modified version of the original script to stop it from upgrading kernel modules due to kernel version mismatch issues.

Credit for original script: https://github.com/danielvijge