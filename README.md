# docker-antivirus
![](https://github.com/wdhif/docker-antivirus/actions/workflows/main.yml/badge.svg)

Docker Antivirus with ClamAV and Atomic

![docker-antivirus](https://user-images.githubusercontent.com/5231539/30380611-5525d520-989a-11e7-96fd-93f8e6294b34.gif)
## Usage

```
docker-antivirus help [COMMAND]                         # Describe available commands or one specific command
docker-antivirus scan -i, --image=IMAGE                 # Scan a docker image
docker-antivirus cleanup                                # Cleanup all folders
```

If for some reason the temporary directories are not correctly deleted, you can add this command to your cron file
```
find /tmp/docker-antivirus/* -type d -mtime +10 -exec umount {} + -exec rm -rf {} +
```
This command with find all subdirectories inside `/tmp/docker-antivirus` with a modification date older than 10 days. Those directories will be unmounted and then deleted.

## Development

1. Install the dependencies (for centos, atomic is in centos-extras).
```
yum install gcc-c++ ruby-devel coreutils clamav atomic
```

2. Install the application dependencies.
```
bundle install
```

3. Run the project.
```
bundle exec docker-antivirus help
```

## Troubleshooting
Because of a problem with Atomic regarding the use of a newer glib2 that is not yet in the current dependancies, you can get an ostree error with python. https://github.com/projectatomic/atomic/issues/1018  
`/usr/bin/python2: symbol lookup error: /lib64/libostree-1.so.1: undefined symbol: g_file_enumerator_iterate`  
To fix this you just have to update glib2 to the newer version.  
`yum update glib2`  


## Contributing

1. Fork it ( https://github.com/wdhif/docker-antivirus/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
