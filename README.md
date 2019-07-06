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

