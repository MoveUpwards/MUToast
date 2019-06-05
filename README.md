<p align="center">
<a href="https://developer.apple.com/swift/">
<img src="https://img.shields.io/badge/Swift-5.0-orange.svg?style=flat" alt="Swift 5.0">
</a>
<a href="http://cocoapods.org/pods/MUToast">
<img src="https://img.shields.io/cocoapods/v/MUToast.svg?style=flat" alt="Version">
</a>
<a href="http://cocoapods.org/pods/MUToast">
<img src="https://img.shields.io/cocoapods/p/MUToast.svg?style=flat" alt="Platform">
</a>
<a href="https://github.com/Carthage/Carthage">
<img src="https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat" alt="Carthage Compatible">
</a>
<a href="https://github.com/apple/swift-package-manager">
<img src="https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg" alt="SPM">
</a>
</p>

# MUToast

<p align="center">
MUToast provides a reusable component to show a title and detail label with `UIAppearance` customization
</p>

<p align="center">
<img src="./MUToast.png" alt="screenshot">
</p>

## Features

- [x] UIAppearance customization
- [x] Easy to reuse in all your projects
- [x] Storyboard and frame compatible
- [x] Easy to include in custom view

## Example

The example application is the best way to see `MUToast` in action. Simply open the `MUToast.xcodeproj` and run the `Example` scheme.

## Installation

### CocoaPods

MUToast is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```bash
pod 'MUToast'
```

### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks.

To integrate MUToast into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "MoveUpwards/MUToast"
```

Run `carthage update` to build the framework and drag the built `MUToast.framework` into your Xcode project. 

On your application targets’ “Build Phases” settings tab, click the “+” icon and choose “New Run Script Phase” and add the Framework path as mentioned in [Carthage Getting started Step 4, 5 and 6](https://github.com/Carthage/Carthage/blob/master/README.md#if-youre-building-for-ios-tvos-or-watchos)

### Swift Package Manager

To integrate using Apple's [Swift Package Manager](https://swift.org/package-manager/), add the following as a dependency to your `Package.swift`:

```swift
dependencies: [
.package(url: "https://github.com/MoveUpwards/MUToast.git", from: "1.0.0")
]
```

### Manually

If you prefer not to use any of the aforementioned dependency managers, you can integrate MUToast into your project manually. Simply drag the `Sources` Folder into your Xcode project.

## Usage

### Code snippet

```swift

```

### UIAppearance styling

Overall application styling

```swift

```

Specific parent class styling

```swift

```

### Available properties

```swift

```

## Contributing
Contributions are very welcome 🙌

## License

```
MUToast
Copyright (c) 2019 Move Upwards contact@moveupwards.dev

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
```

