# Fastlane

<img alt="Fastlane Logo" src="https://docs.fastlane.tools/img/fastlane_text.png" />

The purpose of this document is to be a step by step guide on how to integrate Fastlane to your project.

* [Getting Started](https://docs.fastlane.tools/getting-started/ios/setup/)

## Cherry-Pick the Github Action to test 🍒
1. Configure Fastlane in your project following the Getting Started guide mentioned above.
2. Add as many custom actions as you want to the `Fastfile`. The [one](../fastlane/Fastfile) in this project is currently:
    - Running `swiftlint` in strict mode (ie: fails on warnings).
    - Running the `unit tests` in the different TestPlans.
    - Running the `ui tests`.
    - Building the app.
3. Copy the [workflow](../.github/workflows/fastlane.yml) to your `.github/workflows/` directory.

