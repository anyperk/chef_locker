# chef_locker

chef_locker is a Ruby gem that contains a script to prevent Chef clients from
converging.

To install, declare something like the following in Chef:
```ruby
chef_gem 'chef_locker'
```

To run the script, try something like the following in a screen/tmux session:
```bash
$ sudo /opt/chefdk/embedded/bin/chef_locker 'Testing CDN host change'
```
Wait until `Lock acquired` appears.

Note that if something like rvm is installed, you may have to create a wrapper
script to unset some Ruby-related environment variables.
