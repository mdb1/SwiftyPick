# SwiftGen

<img alt="SwiftGen Logo" src="https://github.com/SwiftGen/Eve/raw/master/logo/logo-256.png" />

The purpose of this document is to be a step by step guide on how to add the `SwiftGen` dependency to your project.
And use it for generating `static` properties for `colors`, `images`, and `strings`.
In addition to that, we can also have unit tests than ensure that all the colors and images exist.
And unit tests for the Localizable strings.

* [SwiftGen project](https://github.com/SwiftGen/SwiftGen)
> SwiftGen is a tool to automatically generate Swift code for resources of your projects (like images, localized strings, etc), to make them type-safe to use.

## Usage
In this project, we are using `SwiftGen` to generate: `colors`, `images` and `strings`. As it can be seen in the [config file](../swiftgen.yml):
```yml
strings:
  inputs:
    - SwiftyPick/Resources/Localizable/en.lproj
  outputs:
    - templateName: structured-swift5
      output: SwiftyPick/Resources/Generated/Strings+Generated.swift

xcassets:
  inputs:
    - SwiftyPick/Resources/Assets/Image.xcassets
    - SwiftyPick/Resources/Assets/Color.xcassets
  outputs:
    - templateName: swift5
      params:
        forceProvidesNamespaces: true
        allValues: true # This one is for testing existence
      output: SwiftyPick/Resources/Generated/Assets+Generated.swift
```

## Testing
As you can see, we've added the `allValues` param to the outputs of `xcassets`.
This allow us to have access to the `allImages` and `allColors` properties on the Unit Tests.
Example:
```swift
func testColorsExist() {
    Asset.Color.allImages.forEach {
        XCTAssertNotNil($0, "All colors in the group should exist")
    }
}
```

In addition to that, we have different Unit Test plans, in order to test Localization (and eventually Number and Date Formatters).
You can check the [UnitTestPlans file](../SwiftyPickTests/UnitTestsPlan.xctestplan) for more info
* Argentina Config -> Using `spanish` language
* United States Config -> Using `english` language

We can add a basic extension to `XCTestCase`:
```swift
enum CountryISOCode {
    /// iso2 code for Argentina
    static let argentina = "AR"
    /// iso2 code for the United States
    static let unitedStates = "US"
}

extension XCTestCase {
    /// Way around getting the current configuration for the unit tests
    enum TestingRegion {
        case argentina
        case unitedStates // default

        static var current: TestingRegion {
            switch Locale.current.regionCode {
            case CountryISOCode.argentina:
                return .argentina
            case CountryISOCode.unitedStates:
                return .unitedStates
            default:
                return .unitedStates
            }
        }
    }
}
```

And then test the localization:
```swift
func testGreetingTranslation() {
    let greetingHello = L10n.Greeting.hello

    switch TestingRegion.current {
    case .argentina:
        // Uses spanish translation
        XCTAssertEqual(greetingHello, "Hola")
    case .unitedStates:
        XCTAssertEqual(greetingHello, "Hello")
    }
}
```

### Future improvement
Write a script that:
1. Fetches the strings from the localizable files
2. Asserts that all the localization strings matches their region

## Steps to cherry-pick 🍒
1. Follow the [Installation guide](https://github.com/SwiftGen/SwiftGen#installation) in the `SwiftGen` repository.
2. Remember to add the `swiftgen` script as one of your build phases.
3. Create a SwiftGen configuration file. You can use [the one](../swiftgen.yml) in this project for inspiration.
4. Build the project and add the `generated` files to Xcode.
5. Optionally create UnitTestPlans and add similar unit tests to the ones in this project. 

