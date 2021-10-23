# Testing using Test Plans

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
      testplan: "UnitTestsPlan"
    )
  end

  desc "Run the regional unit tests"
  lane :unit_tests_regional do
    run_tests(
      testplan: "RegionalTestsPlan"
    )
  end

  desc "Run the UI tests"
  lane :ui_tests do
    run_tests(
      testplan: "UITestsPlan"
    )
  end
```

Then in the lane you will run on CI:
```yml
  desc "Sanity checks to run on CI"
  lane :sanity_checks do
    unit_tests_full_plan
    unit_tests_regional
    ui_tests
  end
```

In this case, we've added a new lane for each test plan:
1. The System Configuration that will run all the tests (`UnitTestsPlan`).
2. The Regional Config, that will only run the tests in the `RegionalTestsPlan` using all it's configurations
    * 🇺🇸 United States with English language.
    * 🇦🇷 Argentina with Spanish language.
3. Run the UI Tests







