/usr/bin/ssh-keygen -q -t rsa -f etc/ssh/ssh_host_rsa_key -C '' -N ''
/usr/bin/chgrp ssh_keys etc/ssh/ssh_host_rsa_key
/usr/bin/chmod 640 etc/ssh/ssh_host_rsa_key
/usr/bin/chmod 644 etc/ssh/ssh_host_rsa_key.pub
