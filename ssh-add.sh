#!/usr/bin/expect -f

spawn -noecho ssh-add /home/brian/.ssh/id_rsa
log_user 0
expect "Enter passphrase for /home/brian/.ssh/id_rsa:"
send "v5D9Duh2R61uaHFG\n";
expect "Identity added: /home/brian/.ssh/id_rsa (brian@brian-hellofresh)"
spawn -noecho ssh-add /home/brian/.ssh/personal
expect "Identity added: /home/brian/.ssh/personal (brian@briarch)"
interact
