# SwiftLint

The purpose of this document is to be a step by step guide on how to add and configure `SwiftLint` to your project.

* [SwiftLint project](https://github.com/realm/SwiftLint)

```swift
A tool to enforce Swift style and conventions, loosely based on the now archived GitHub Swift Style Guide.
SwiftLint enforces the style guide rules that are generally accepted by the Swift community.
```

## Steps to cherry-pick 🍒
You can follow the steps provided by [this article](https://medium.com/developerinsider/how-to-use-swiftlint-with-xcode-to-enforce-swift-style-and-conventions-368e49e910).

1. Install `swiftlint`: `brew install swiftlint`.
2. Integrate SwiftLint with Xcode.
Add a build phase to your project:
```bash
if which swiftlint >/dev/null; then
  swiftlint
else
  echo "warning: SwiftLint not installed, download from https://github.com/realm/SwiftLint"
fi
```
3. Build the project and fix the warnings.

## Custom configuration
Additionally, you can opt_in or opt_out to other `SwiftLint` rules. The full list of rules is available [here](https://realm.github.io/SwiftLint/rule-directory.html).
In order to add custom configuration, create a `.swiftlint.yml` file under the root directory of your project.
See [here](../.swiftlint.yml) for an example.

## Hide Pod Warnings
You can hide Pod warnings from your Xcode Project by adding inhibit_all_warnings! in your Podfile for all 3rd party dependencies 
or :inhibit_warnings => true for specific dependency.

### Example:
```bash
platform :ios
# ignore all warnings from all dependencies
inhibit_all_warnings!
# ignore warnings from a specific dependency
pod 'FBSDKCoreKit', :inhibit_warnings => true
```

Then you need to execute `pod install`.

## Custom rules enabled in this project
In order to guarantee certain code standards, this repository has a lot of custom rules enabled:
- anyobject_protocol
- array_init
- closure_body_length
- closure_end_indentation
- collection_alignment
- contains_over_filter_is_empty
- contains_over_first_not_nil
- convenience_type
- empty_collection_literal
- empty_count
- empty_string
- empty_xctest_method
- enum_case_associated_values_count
- extension_access_modifier
- fatal_error_message
- first_where
- force_unwrapping
- identical_operands
- implicit_return
- indentation_width
- joined_default_parameter
- last_where
- let_var_whitespace
- literal_expression_end_indentation
- modifier_order
- multiline_arguments
- multiline_arguments_brackets
- multiline_function_chains
- multiline_literal_brackets
- multiline_parameters
- multiline_parameters_brackets
- number_separator
- operator_usage_whitespace
- operator_whitespace
- override_in_extension
- overridden_super_call
- pattern_matching_keywords
- prefer_self_type_over_type_of_self
- prohibited_interface_builder
- prohibited_super_call
- sorted_first_last
- switch_case_on_newline
- toggle_bool
- unneeded_break_in_switch
- unneeded_parentheses_in_closure_argument
- unowned_variable_capture
- untyped_error_in_catch
- unused_import
- yoda_condition

## Usage
* Run the `swiftlint` command in the console to see the `warnings` and `errors`.
* Run the `swiftlint autocorrect` to solve some of the `warnings`.
