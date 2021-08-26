# Sort Project Script

The purpose of this document is to be a step by step guide on how to add the `sort.pl` script to your project.

* [Reference](https://github.com/withzombies/sort-xcodeproj)

## Idea
Add a script that sorts all the files and groups inside the project alphabetically.
Check that the files are sorted in the pre-commit hook.

## Why?
The idea behind this script is to:
* Keep the project structure well-organized, and easy to navigate. (Similar to the one in Android Studio 🤖)
* Reduce the chance of having conflicts due to long-lived feature branches in the `.pbxproj` file.
* Guarantee the project structure before every commit via the `pre-commit` hook.

## Usage
> `perl ./scripts/sort.pl SwiftyPick.xcodeproj/`

## Steps to cherry-pick 🍒
1. Copy the script in [sort.pl](scripts/sort.pl) to your project. (Recommendation: Place it under a `scripts` directory)
2. Run the script using `perl ./scripts/sort.pl NameOfYourProject.xcodeproj/`. This should sort all your files.
3. To add the pre-commit hook check, create a `.githooks` directory in the root of your project.
4. Copy the [pre-commit file](.githooks/pre-commit) from this project to your new directory.
5. Run `git config core.hooksPath .githooks` in your root directory. This will configure the repository to use the pre-commit hook.
