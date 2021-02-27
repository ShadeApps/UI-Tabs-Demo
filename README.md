# UI Tabs Demo

iOS app for an interview project written entirely in Swift 5.3.2 with very custom UI featuring Dark Mod.

## Requirements

**Xcode version 12.3 (12C33)** with **iOS 14.3 SDK** required.
Supported iOS Versions - iOS 11 and up
**CocoaPods** is also a must.

## Installation

Clone the repo and run ```$ pod install``` in the project folder.

# Functionality

The app is currently able to load data, group it by date and show it in a Table View.

* When the app loads, load data from API, showing a dynamic, scrollable skeleton loader
* If there are some errors, the app will react to that accordingly
* You can switch and swipe between tabs, scroll the first tab and enjoy the dynamic navigation bar
* The app also features Dark Mode support

# Development Steps

0. Create new project based on single view app pattern
1. Add different Pods for all the use cases
2. Create folders for MVVM pattern, create initial UI
3. Add all UI classes and all cell types
4. Add support for colors and correct assets in Asset Catalog
5. Add support for Dark Mode
6. Add Networking Layer to handle the API
7. Added Tests for Networking Layer
8. Added DateFromatter
9. Add Models and ViewModel, that will show the elements in Table View
10. Passed all the data to table view cells
11. Fix UI for smaller devices

## Trivia

Project is built with Storyboards and Autolayout, heavily relying on R.swift library for strngly typed-constants.
It also relies heavily on the Tabman library for the main screen and switching between tabs.

## Contributing

We'd love to see your ideas for improving this project! The best way to contribute is by submitting a pull request. We'll do our best to respond to your patch as soon as possible. You can also submit a [new Github issue](https://github.com/ShadeApps/camera-app-template/issues/new) if you find bugs or have questions. :octocat:
