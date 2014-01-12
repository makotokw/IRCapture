IRCapture
=====================

The developer tools for [IRKit](http://getirkit.com/).

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