[![Teapot](logo/teapot_logo.png)](logo/teapot_logo.png)

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

Teapot necessary configuration file named `teapot.yml`.
Teapot can prepare `teapot.yml` to under the current directory via `$ teapot setup`.
```swift
$ teapot setup
🍵 Teapot setup completion. You can edit ./teapot.yml 🍵
```

Next, Teapot can be execute your shell command for each file when file modified for it according to `teapot.yml` configuration. 

```swift
$ teapot start
🍵 Teapot start 🍵
```

## LICENSE
Teapot is available under the MIT license. See the LICENSE file for more info.

