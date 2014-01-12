IRCapture
=====================

The developer tools for [IRKit](http://getirkit.com/).

[![](https://dl.dropboxusercontent.com/u/8932138/screenshot/IRCapture/IRCapture_01_300x432.png)](https://dl.dropboxusercontent.com/u/8932138/screenshot/IRCapture/IRCapture_01.png)
[![](https://dl.dropboxusercontent.com/u/8932138/screenshot/IRCapture/IRCapture_02_300x432.png)](https://dl.dropboxusercontent.com/u/8932138/screenshot/IRCapture/IRCapture_02.png)

## Requirements

* [IRKit](http://getirkit.com/) Device
* [IRKit](http://getirkit.com/) ApiKey
* [CocoaPods](http://cocoapods.org/)

## Setup

```
git clone https://github.com/makotokw/IRCapture.git
cd IRCapture
cp -p IRCapture/IRCaptureConfig.h.sample IRCapture/IRCaptureConfig.h
pod install
open IRCapture.xcworkspace
```

Edit IRCapture/IRCaptureConfig.h to set your ApiKey before xcode executes build. 

## License

The MIT License (MIT)