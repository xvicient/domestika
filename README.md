
# Domestika iOS

## Installation

To run the project, clone the repo and run `pod update` from the root directory first.

## Requirements

**Minimum iOS target:** iOS 13.0

**CocoaPods** 1.9.3

## About

**Architecture**

Modular app structured using VIPER architecture. All components of each module have their own responsibility trying to reduce the load and the dependency on controllers.

**API**

Based on Domestika [resource](http://mobile-assets.domestika.org/challenge/home.json).

**Testing**

Full Unit Testing using [SwiftyMocky](https://github.com/MakeAWishFoundation/SwiftyMocky).<br/>
API data testing using [OHHTTPStubs](https://github.com/AliSoftware/OHHTTPStubs).

**Frameworks**

[Swinject](https://github.com/Swinject/Swinject) used to define the app dependencies.<br/>
[SnapKit](https://github.com/SnapKit/SnapKit) used to make Auto Layout programatically.<br/>
[Nuke](https://github.com/kean/Nuke) used to download and display images on the app.<br/>
[SwiftLint](https://github.com/realm/SwiftLint) used to enforce Swift style and conventions.<br/>
[SwiftFormat](https://github.com/nicklockwood/SwiftFormat) used to reformatting Swift code.<br/>
[SwiftyMocky](https://github.com/MakeAWishFoundation/SwiftyMocky) used to build mocks in runtime. Depends on Sourcery, which scans the source code and generates mocks.<br/>
[OHHTTPStubs](https://github.com/AliSoftware/OHHTTPStubs) used to stub network requests on service tests.

## Changes

See the [CHANGELOG](CHANGELOG.md) for more info.

## Author

Xavier Vicient Manteca

## License

Copyright © 2020 Xavier Vicient Manteca.
