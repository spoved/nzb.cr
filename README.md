# nzb

[![Build Status](https://travis-ci.com/spoved/nzb.cr.svg?branch=master)](https://travis-ci.com/spoved/nzb.cr)

Small wrapper library to read and write NZB files

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     nzb:
       github: spoved/nzb.cr
   ```

2. Run `shards install`

## Usage

```crystal
require "nzb"

nzb = Nzb.open("path to nzb")
```

## Contributing

1. Fork it (<https://github.com/spoved/nzb.cr/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Holden Omans](https://github.com/kalinon) - creator and maintainer
