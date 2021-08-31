fastlane documentation
================
# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```
xcode-select --install
```

Install _fastlane_ using
```
[sudo] gem install fastlane -NV
```
or alternatively using `brew install fastlane`

# Available Actions
## iOS
### ios sanity_checks
```
fastlane ios sanity_checks
```
Sanity checks to run on CI
### ios build
```
fastlane ios build
```
Build the app
### ios unit_tests_full_plan
```
fastlane ios unit_tests_full_plan
```
Run the unit tests default plan
### ios unit_tests_regional
```
fastlane ios unit_tests_regional
```
Run the regional unit tests (US Config)
### ios ui_tests
```
fastlane ios ui_tests
```
Run the UI tests
### ios swiftlint_strict
```
fastlane ios swiftlint_strict
```
Run swiftlint in strict mode

----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
