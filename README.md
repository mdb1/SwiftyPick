# SwiftyPick 🦅🍒

Useful Swift code samples, extensions, functionalities and scripts to cherry-pick and use in your projects.

## Purpose

The idea behind this project is not to be a `pod` that users import into their own projects, but rather a collection of useful ideas, well-organized and documented, to cherry-pick as needed into another projects.
Every new piece of functionality will have a proper document explaining it's usage under the `Documentation` directory.

## Installation

### SwiftLint
 > `brew install swiftlint`
 
### Configure the Git Hooks
 > `git config core.hooksPath .githooks`
 
 ### CocoaPods
 > Run `pod install` on the root of the project
 > Open `SwiftyPick.xcworkspace` with Xcode

# Features 🚀

## Code

### Extensions

#### [Add support for multiple Color Palettes](Documentation/ColorPalette.md)

### Features

#### [SwiftGen](Documentation/SwiftGen.md)
> Use the `SwiftGen` dependency to get autogenerated instances of colors, images, and localized strings.

### Networking
`// TODO //`

### UI
`// TODO //`

## Process

### Danger
#### [Configuring Danger](Documentation/Danger.md)
> Configure Danger and add a Github Action to run the script on every PR.

### Fastlane
#### [Configuring Fastlane](Documentation/Fastlane.md)
> Configure Fastlane in your project and add a Github Action to run the tests on every PR to `main`.

### Github

#### [Set up PR and Issue templates](Documentation/GithubTemplates.md)
> How to add a Pull Request or Issue template to your project.

#### [Github Actions](Documentation/GithubActions.md)
> How to add a Github Actions and make them run on Pull Requests.

### SwiftLint

#### [Configure SwiftLint in your project](Documentation/SwiftLint.md)
> How to add and configure SwiftLint rules.

### Scripts

#### [Sort Project files alphabetically](Documentation/SortProject.md)
> Keep the Xcode project files sorted alphabetically and avoid conflicts in the `.pbxproj` file

# Contributing

Check out the [Contributing guide](.github/CONTRIBUTING.md)
