<?php

$cmd = ''; // Set $cmd to 'reboot' in order to reboot the router.
$hash = substr(hash('sha256', filemtime(__FILE__)), 0, 7);

printf("%s.%s", $cmd, $hash);

?>