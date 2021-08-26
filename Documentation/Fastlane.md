# Fastlane

The purpose of this document is to be a step by step guide on how to integrate Fastlane to your project.

* [Getting Started](https://docs.fastlane.tools/getting-started/ios/setup/)

## Cherry-Pick the Github Action to test 🍒
1. Configure Fastlane in your project following the Getting Started guide mentioned above.
2. Configure your Fastfile to look like this:
```
platform :ios do
  desc "Lane to run the unit tests"
  lane :unit_tests do
    run_tests(testplan: "UnitTestsPlan")
  end
end
```
3. Copy the [workflow](../.github/workflows/fastlane_test.yml) to your `.github/workflows/` directory.

