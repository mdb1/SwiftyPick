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
### ios unit_tests
```
fastlane ios unit_tests
```
Run the unit tests
### ios swiftlint_strict
```
fastlane ios swiftlint_strict
```
Run swiftlint in strict mode
### ios test_coverage
```
fastlane ios test_coverage
```
Check test coverage

----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
