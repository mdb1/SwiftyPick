# Github Actions

The purpose of this document is to be a step by step guide on how to add Github Actions to your project.

* [Github documentation](https://docs.github.com/en/actions)

## Steps
1. Create a `workflows` directory under the `.github` folder in your project
2. Inside that directory, you can create `.yml` files that will describe each Github action and when to run them

## Cherry-Pick the Build and Test Action
The `Build and Test` github action in this project does exactly what it's title says, it just build the project and run the unit tests.
To add it to your project, copy the [action](../.github/workflows/build_and_test.yml) file inside you `.github/workflows` folder.
It will be run every time you create a new PR against the `main` branch.

## Cherry-Pick the Swiftlint Action
The `SwiftLint` github action runs the SwiftLint script and comments any warnings/errors in the git diff.
To add it to your project, copy the [action](../.github/workflows/swiftlint.yml) file inside you `.github/workflows` folder.
It will be run every time you create a new PR against the `main` branch.

## Cherry-Pick the Danger Action
Check the [Danger](Danger.md) documentation inside this project.


