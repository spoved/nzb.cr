# nzb

<p align="center">
    <a href="https://github.com/spoved/nzb.cr/actions/workflows/build.yml">
        <img src="https://github.com/spoved/nzb.cr/actions/workflows/build.yml/badge.svg" alt="Build Status"></a>
    <a href="https://github.com/spoved/nzb.cr/actions/workflows/release.yml">
        <img src="https://github.com/spoved/nzb.cr/actions/workflows/release.yml/badge.svg" alt="Release Status"></a>
    <a href="https://github.com/spoved/nzb.cr/releases">
        <img src="https://img.shields.io/github/v/release/spoved/nzb.cr" alt="Latest release"></a>
</p>

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
