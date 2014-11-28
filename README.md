IRCapture
=====================

The developer tools for [IRKit](http://getirkit.com/).

[![](https://dl.dropboxusercontent.com/u/8932138/screenshot/IRCapture/IRCapture_01_300x432.png)](https://dl.dropboxusercontent.com/u/8932138/screenshot/IRCapture/IRCapture_01.png)
[![](https://dl.dropboxusercontent.com/u/8932138/screenshot/IRCapture/IRCapture_02_300x432.png)](https://dl.dropboxusercontent.com/u/8932138/screenshot/IRCapture/IRCapture_02.png)

## Requirements

* IRKit Device
* IRKit API Key ([Get API key](https://github.com/irkit/ios-sdk#get-api-key))
* [CocoaPods](http://cocoapods.org/) 0.35+

## Setup

```
git clone https://github.com/makotokw/IRCapture.git
cd IRCapture
cp -p IRCapture/IRCaptureConfig.h.sample IRCapture/IRCaptureConfig.h
pod install
open IRCapture.xcworkspace
```

Please edit ``IRCaptureConfig.h`` file to set your API Key before run.

## License

The MIT License (MIT)
