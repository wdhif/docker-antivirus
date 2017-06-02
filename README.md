# docker-antivirus
[![Build Status](https://travis-ci.org/wdhif/docker-antivirus.svg?branch=master)](https://travis-ci.org/wdhif/docker-antivirus)

Docker Antivirus with ClamAV and Atomic

![demo](https://cloud.githubusercontent.com/assets/5231539/26585609/e8079b36-454c-11e7-833d-621ef29d7bee.png)

## Usage

```
docker-antivirus help [COMMAND]                         # Describe available commands or one specific command
docker-antivirus scan -i, --image=IMAGE                 # List the 20 last pipelines for a project
docker-antivirus cleanup                                # Get a pipeline status
```

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
