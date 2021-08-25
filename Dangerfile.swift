import Danger

let danger = Danger()

// Pull request size
let bigPRThreshold = 400
let shortTitleThreshold = 5
let additions = danger.github.pullRequest.additions!
let deletions = danger.github.pullRequest.deletions!
let changedFiles = danger.github.pullRequest.changedFiles!

// Check PR size Threshold
if (additions + deletions > bigPRThreshold) {
    warn("PR size seems relatively large. ✂️ If this PR contains multiple changes, please split each into separate PR will helps faster, easier review.")
}

// Pull request body validation
if danger.github.pullRequest.body == nil || danger.github.pullRequest.body!.isEmpty {
    warn("PR has no description. 📝 You should provide a description of the changes that have made.")
}

// Pull request title validation
let prTitle = danger.github.pullRequest.title
if prTitle.contains("WIP") {
    warn("PR is classed as _Work in Progress_.")
}
if prTitle.count < shortTitleThreshold {
    warn("PR title is too short. 🙏 Please use a more descriptive title")
}

// Files changed and created should includes unit tests
let modified = danger.git.modifiedFiles
let editedFiles = modified + danger.git.createdFiles
let testFiles = editedFiles.filter { ($0.contains("Tests") || $0.contains("Test")) && ($0.fileType == .swift) }
if testFiles.isEmpty {
    warn("PR does not contain any files related to unit tests ✅ (ignore if your changes do not require tests)")
}

// MARK: - SwiftLint
//SwiftLint.lint() - TODO: Make this work

message("🎉 The PR added \(additions) and removed \(deletions) lines. 🗂 \(changedFiles) files changed.")
