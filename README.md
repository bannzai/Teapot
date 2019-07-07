<div align="center" >
  <img width="50%" src="logo/teapot_logo.png" />
</div>

[![swift5.0](https://img.shields.io/badge/language-swift5.0-blue.svg?style=flat)](https://developer.apple.com/swift)
[![Platform](https://img.shields.io/badge/platform-macOS-green.svg)](https://img.shields.io/badge/platform-macOS-green.svg)
[![License](http://img.shields.io/badge/license-MIT-000000.svg?style=)](https://github.com/bannzai/Teapot/blob/master/LICENSE)

## Teapot
Teapot is command line tool writen by Swift.  
It can be execute your shell command for each file, when file modified.

## Required
Swift 5.0 or later.
And it require to run on macOS.


## Install
Using mint. 
```shell
$ mint install bannzai/Teapot
```

## Usage
First, Teapot necessary configuration file named `teapot.yml`.
Teapot can prepare `teapot.yml` to under the current directory via `$ teapot setup`.
```swift
$ teapot setup
🍵 Teapot setup completion. You can edit ./teapot.yml 🍵
```

This will generate the following file:
```yaml
source:
- build/*
- Sources/*.*
- Sources/Teapot/*.*
ignore:
- ".git"
- ".gitignore"
- tests/*
execute: 
- ls -la __FILE__
- echo $HOME
```

- `source` is target file of listen to changing.
- `ignore` is ignored target file of listen to changing.
- `execute` is exec shell command for changed target file.
- `__FILE__` is mark of changed file. So, It is replaced when file changed.

Next, Teapot can be execute your shell command for each file when file modified for it according to `teapot.yml` configuration. 

```swift
$ teapot start
🍵 Teapot start 🍵
```

For example, when you edit some file, teapot display result of `$ ls -la` to changed file.

## LICENSE
[Teapot](https://github.com/bannzai/Teapot/) is released under the MIT license. See [LICENSE](https://github.com/bannzai/Teapot/blob/master/LICENSE.txt) for details.

Header logo is released [CC BY-NC 4.0](https://creativecommons.org/licenses/by-nc/4.0/deed) license. Original design by [noainoue](https://github.com/noainoue).<Paste>
