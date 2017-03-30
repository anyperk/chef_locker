# chef_locker

chef_locker is a Ruby gem that contains a script to prevent Chef clients from
converging.

### Installation
To install, declare something like the following in Chef:
```ruby
chef_gem 'chef_locker'
```

To run the script, try something like the following in a screen/tmux session:
```bash
$ sudo /opt/chefdk/embedded/bin/chef_locker 'Testing CDN host change'
```
Note that if something like rvm is installed, you may have to create a wrapper
script to unset some Ruby-related environment variables.

### Running chef_locker
Run `sudo -H chef_locker [message with reason why]` in a screen/tmux session and wait for `Lock acquired` to appear. Then detach from your screen/tmux session to keep Chef stopped (`ctrl`+`b` `d` in tmux).

To remove the lock and reenable Chef again, kill the process (`ctrl` + `c`).
