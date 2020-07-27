# blocky

Blocky is a command line tool to help you easily block websites, and unblock them when you need them. It modifies /etc/hosts file and add appropriate configuration.

In today’s world though it is difficult to continue blocking a few websites because they are quite useful too. And hence, blocky lets you activate and deactivate focus mode, so that you are able to access blocked websites when you are relaxing.

## Installation


## Usage/Commands
### block (shortcut b or -b)
Use this command to block any website you want. It can take one or more websites as input, just separate them by space.
Please take care to add the exact website URL you want to block - a few websites add www as a subdomain and to block them you will have to add that to in the name of the website.
**Examples**
```
$ # block youtube
$ sudo blocky block www.youtube.com

$ # use shortcut -b to block youtube
$ sudo blocky -b www.youtube.com

$ # block multiple websites in one shot
$ sudo blocky -b www.facebook.com www.youtube.com

$ # take care to provide exact URLs you want to block
$ sudo blocky -b www.facebook.com m.facebook.com
```

### unblock (shortcut u or -u)
Use this command to unblock any website you have previously blocked using blocky. It can take one or more space separated websites as input.

It is a safe command, and does not return error if website was not blocked.
```
$ # unblock youtube
$ sudo blocky unblock www.youtube.com

$ # use shortcut -u to unblock youtube
$ sudo blocky -u www.youtube.com

$ # unblock multiple websites in one shot
$ sudo blocky -u www.facebook.com www.youtube.com

$ # take care to provide exact URLs you want to unblock
$ sudo blocky -u www.facebook.com m.facebook.com
```

### activate (shortcut a or -a)
Use this command to activate focus mode. This is a sort of shortcut to block all the websites you have added to blocky and remove all the distracting websites.

```
$ # activate focus mode
$ sudo blocky -activate

$ # use shortcut -a to activate focus mode
$ sudo blocky -a
```

### deactivate (shortcut d or -d)
Use this command to deactivate focus mode. This unblocks all the websites you have added to blocky.

```
$ # deactivate focus mode
$ sudo blocky deactivate

$ # use shortcut -d to deactivate focus mode
$ sudo blocky -d
```

### help (or -h)
Use this command to know more about blocky commands. You can also use this command with other commands to get command specific help.

```
$ # see all blocky commands
$ sudo blocky help

$ # get help with respect to a particular command
$ sudo blocky activate -h
```

###### Please Note
* Given we are modifying /etc/hosts file, you will have to run blocky as an administrator or as a root user.
* blocky also uses special markers to identify changes done by it, so please don’t manually update entries added by blocky, use blocky commands instead

### TODO
* Write tests
* Persist blocked & unlocked settings with activate & deactivate commands
* Test it on Linux
* Port it on Windows


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/abhinavs/blocky. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/blocky/blob/master/CODE_OF_CONDUCT.md).


## Code of Conduct

Everyone interacting in the Blocky project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/blocky/blob/master/CODE_OF_CONDUCT.md).

## Copyright

Copyright (c) 2020 Abhinav Saxena. See [MIT License](LICENSE.txt) for further details.
