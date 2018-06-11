Simple C2
=======
I use OpenVPN to connect to my home network when I'm away to do various tasks. One time something went wrong and I was no longer able to connect to my VPN server. After coming home and investigating, it turned out there was some soft crash that killed OpenVPN, and could have been resolved either with a service restart or a reboot.

I wish to avoid that in the future. Since `reboot` is the ultimate fix for everything, I made this.

**C2-Server (`c2-server.php`):**
PHP script that runs on a trusted server you control. It echos the predefined command to be executed. This can be PHP, Node, Python, whatever, as long as it can output a string as a response to an HTTP request.

**C2-Client  (`c2-client.sh`):**
Shell script that runs regularly as a cron job to ask the server about which predefined command to execute.

**Notes:**
1. By design, only predefined command strings are accepted. If your server is pwned, you don't want to also give the attacker RCE to your router. Worst case scenario now if the trusted server is compromised is the router rebooting once an hour until the script is disabled.
2. The hash is not for security. It's there just to make sure that the command doesn't accidentally keep getting executed forever.
3. In the future, I might add a few other helpful commands like restarting a specific service or setting some config values, etc.