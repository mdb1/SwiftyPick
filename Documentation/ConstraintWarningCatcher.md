# Constraint Warning Catcher

A single class to start tracking all the broken NSLayoutConstraints in your codebase. Based on this [article](https://swiftrocks.com/detecting-broken-constraints-in-swift?utm_source=swiftlee&utm_medium=swiftlee_weekly&utm_campaign=issue_90).

The idea is to use method swizzling to detect the moment a constraint will break and track it to a third party library (Firebase/Datadog/AppCenter/etc).

***Remember to only use this code on debug mode.***

## Cherry-Picking 🍒
1. Copy the ConstraintsWarningCatcher class into your project
    * [ConstraintsWarningCatcher](../SwiftyPick/Presentation/Common/ConstraintsWarningCatcher.swift)
2. The `isDebug` variable is just checking whether we are on debug or on release mode:
```swift
var isDebug: Bool {
#if DEBUG
    return true
#else
    return false
#endif
}
```
3. On the AppDelegate's `didFinishLaunchingWithOptions` method, add this line:
```swift
ConstraintWarningCatcher.shared.startListening()
```