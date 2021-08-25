# Contributing to SwiftyPick

🦅🍒 First off, thanks for taking the time to contribute! 🍒🦅

The following is a set of guidelines for contributing to `SwiftyPick`, which is hosted on GitHub. These are mostly guidelines, not rules. Use your best judgment, and feel free to propose changes to this document in a pull request.

## What should I know before I get started?

The only thing that you need to do before contributing is to check whether the thing (feature, code sample, test, etc) you want to add has not been already added to the project.  

## How Can I Contribute?

### Reporting Bugs

If you find a bug in the code, feel free to create a new Github Issue:

* **Use a clear and descriptive title** for the issue to identify the problem.
* **Describe the exact steps which reproduce the problem** in as many details as possible. When listing steps, **don't just say what you did, but explain how you did it**.
* **Describe the behavior you observed after following the steps** and point out what exactly is the problem with that behavior.
* **Explain which behavior you expected to see instead and why.**
* **Include screenshots and animated GIFs** which show you following the described steps and clearly demonstrate the problem.
* **If the problem wasn't triggered by a specific action**, describe what you were doing before the problem happened.

### Pull Requests

The process described here has several goals:

- Maintain `SwiftyPick`'s quality
- Engage the community in working toward the best possible `SwiftyPick`s
- Enable a sustainable system for `SwiftyPick`'s maintainers to review contributions

Please follow these steps to have your contribution considered by the maintainers:

1. Follow all instructions in [the template](PULL_REQUEST_TEMPLATE.md)
2. Follow the [styleguides](#styleguides)
3. Before merging, the branch should be rebased to latest `main`. This is a requirement to guarantee an easy to read history on the repository.

While the prerequisites above must be satisfied prior to having your pull request reviewed, the reviewer(s) may ask you to complete additional design work, tests, or other changes before your pull request can be ultimately accepted.

## Styleguides

### Git Commit Messages

* Use the present tense ("Add feature" instead of "Added feature")
* Use the imperative mood ("Move cursor to..." not "Moves cursor to...")
* Limit the first line to 80 characters or less
* Reference issues and pull requests liberally after the first line
* Consider starting the commit message with an applicable emoji:
    * :art: `:art:` when improving the format/structure of the code
    * :racehorse: `:racehorse:` when improving performance
    * :non-potable_water: `:non-potable_water:` when plugging memory leaks
    * :memo: `:memo:` when writing docs
    * :bug: `:bug:` when fixing a bug
    * :scissors: `:scissors:` when removing code or files
    * :test_tube: `:test_tube:` when adding tests
    * :lock: `:lock:` when dealing with security
    * :arrow_up: `:arrow_up:` when upgrading dependencies
    * :arrow_down: `:arrow_down:` when downgrading dependencies
    * :shirt: `:shirt:` when removing linter warnings

### Swift Styleguide

* Follow the rules specified by the swiftlint rules file 🚓

### Documentation Styleguide

* When adding new functionality, it's important to add a new markdown file under `Documentation/` explaining how to cherry-pick that functionality into another project.
* It's also important to add a new entry in the `README` referencing the new doc.
