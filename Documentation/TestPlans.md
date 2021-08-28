#  Testing using Test Plans

The purpose of this document is to explain how to add Test Plans to your projects and how to use them.

* [Detailed explanation](https://useyourloaf.com/blog/xcode-test-plans/)

In the case of this project we will use two different test plans for the unit tests:
* `UnitTestsPlan.xctestplan`

    Here we will execute all the suit of unit tests using the system configuration.
    This will be the `default` test plan, and should have the `Automatically include new tests` option enabled.
* `RegionalTestsPlan.xctestplan`

    In this one we will only run the ones that rely on the region/language of the phone. ie: Localization, Formatters, etc.
    We first need to add the UnitTest target, and manually disable all the tests that we don't want in this target.
    Then a good idea would be to disable the `Automatically include new tests` option, and only add tests manually to this test plan.
    
## Running the test plans on CI (FastLane)
In order to run the new configurations on CI (Using FastLane) we need to modify our `Fastfile`:
```yml
  desc "Run the unit tests default plan"
  lane :unit_tests_full_plan do
    run_tests(
      device: "iPhone SE (2nd generation)",
      testplan: "UnitTestsPlan",
      only_test_configurations: "System Config"
    )
  end

  desc "Run the regional unit tests (US Config)"
  lane :unit_tests_regional_us do
    run_tests(
      device: "iPhone SE (2nd generation)",
      testplan: "RegionalTestsPlan",
      only_test_configurations: "United States Config - English"
    )
  end

  desc "Run the regional unit tests (ARG Config)"
  lane :unit_tests_regional_arg do
    run_tests(
      device: "iPhone SE (2nd generation)",
      testplan: "RegionalTestsPlan",
      only_test_configurations: "Argentina Config - Spanish"
    )
  end
```

Then in the lane you will run on CI:
```yml
  desc "Sanity checks to run on CI"
  lane :sanity_checks do
    unit_tests_full_plan
    unit_tests_regional_us
    unit_tests_regional_arg
  end
```

In this case, I've added a new lane for each of the configurations:
1. The System Configuration that will run all the tests (`UnitTestsPlan`).
2. The US Regional Config, that will only run the tests in the `RegionalTestsPlan` with the region set to United States 🇺🇸 and the language set to English.
3. The US Regional Config, that will only run the tests in the `RegionalTestsPlan` with the region set to Argentina 🇦🇷 and the language set to Spanish.

Adding new regions would only imply adding one more lane.

### Disclaimer
We could actually use only one lane for the RegionalTests and set the array of configs (us, arg, etc) to the  `only_test_configurations` property. However, currently we are having a lot of problems with Github Actions taking too long to boot the iOS simulator, and failing the tests due to that. So a workaround for now is to run each configuration in a different lane. This seems to have solved the problem.






