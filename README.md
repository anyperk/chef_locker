# chef_locker

chef_locker is a Ruby gem that contains a script to prevent Chef clients from
converging.

### Installation
To install, declare something like the following in Chef:
```ruby
chef_gem 'chef_locker'
```

Note that if something like rvm is installed, you may have to create a wrapper
script to unset some Ruby-related environment variables.

### Running
Run `sudo -H chef_locker [message with reason why]` in a screen/tmux session and wait
for `Lock acquired` to appear. Then detach from your screen/tmux session to keep Chef
stopped (`ctrl`+`b` `d` in tmux).

To remove the lock and reenable Chef again, kill the process (`ctrl` + `c`).
