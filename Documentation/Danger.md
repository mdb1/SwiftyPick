# Danger

The purpose of this document is to be a step by step guide on how to add Github Templates to your project.

* [Danger repo](https://github.com/danger/swift)

The current configuration of Danger in this project is just performing some basic checks on the PRs styles

## Steps
1. Follow the installation docs on the `Danger` repo, since this may vary with time.
2. To copy the configuration from this project into yours, check out the contents of the [Dangerfile.swift file](../Dangerfile.swift).
3. To make the `Danger` script run using github actions, check out the contents of the [action .yml file](../.github/workflows/danger.yml) 

