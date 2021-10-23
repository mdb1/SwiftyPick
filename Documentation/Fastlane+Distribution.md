#  Fastlane + Distribution

The purpose of this document is to be a step by step guide on how to automate app distribution (via Testflight) using Fastlane and Github Actions

The following links will be useful:
* [Using App Store Connect API with fastlane](https://pgu.dev/2021/06/26/app-store-connect-access-key.html)
* [Automate certificate and profile creation using fastlane](https://pgu.dev/2021/07/05/auto-cert-and-profile-generation.html)
* [App upload via GitHub Actions](https://pgu.dev/2021/09/21/automated-release.html)

## Using App Store Connect API with fastlane
1. The first thing we will need is a private key (in base64), the key id and the issuer id.
    1. We can create it on the [AppStoreConnect](https://appstoreconnect.apple.com/access/api). Selecting role `App Manager` is enough.
    2. Download the `p8` key to your desktop and name it `key.p8`.
    3. Run `cat key.p8 | base64` on your terminal to get the `base64` representation.
    4. The key id and issuer id are on available [AppStoreConnect](https://appstoreconnect.apple.com/access/api).
2. Store the values on a new file called `.env` inside the Fastlane folder.
    1. Remember to add `fastlane/.env` to your gitignore
    2. APP_STORE_CONNECT_API_KEY_KEY_ID="key id value" \
    APP_STORE_CONNECT_API_KEY_ISSUER_ID="issuer id value" \
    APP_STORE_CONNECT_API_KEY_KEY="key in base64 (output of the point `1.3`)"
    3. Also add those key/value pairs to Github Secrets (for later usage in Github Action)
3. Now you can add a new line to your `Fastfile` to upload a build to Testflight:
```yml
lane :upload do
app_store_connect_api_key(
    is_key_content_base64: true
)
build_app
upload_to_testflight
end
```

## Automate certificate and profile creation using fastlane
Given we already have App Store Connect API keys generated and working, we need to do 2 more things to automate certificate and profile creation:

* Setup private repository which will store encrypted certificates and profiles
* Setup fastlane to sync certificates and profiles between repository and development machine

1. First, create a private repository and create an access token which will enable to read/write certificates to the repository without user credentials.
    1. We will use this private repository to store and retrieve the certificates and profiles
2. Right after that, run `fastlane match init` in the project folder (the one which is going to use certificates).
3. Now we can generate certificates using command `fastlane match appstore/fastlane match development`
    1. This will require a password for encryption/decryption. Use a strong password and save it somewhere safe.
```yml
desc "Sync certificates from private repo"
lane :sync_certs do
match(
    git_branch: "main",
    type: "appstore",
    profile_name: "SwiftyPick AppStore",
    app_identifier: "mdb.SwiftyPick"
)

match(
    git_branch: "main",
    type: "development",
    profile_name: "SwiftyPick Development",
    app_identifier: "mdb.SwiftyPick"
)
end
```
4. Add these values to your `.env` file and to Github Secrets:
    1. MATCH_GIT_BASIC_AUTHORIZATION="the access token generated in point `1`"
    2. MATCH_PASSWORD="the encryption/decryption password used in point `3.1`"

## App upload via GitHub Actions
Now we just need to:

* Create fastlane action with release flow
* Create GitHub workflow based on preferred events

1. Add a new lane in your Fastfile:
```yml
desc "Upload to testflight"
lane :distribute_to_testflight do
app_store_connect_api_key(
    is_key_content_base64: true
)
if is_ci
    setup_ci
end
sync_certs
bundle_install
cocoapods
increment_build_number(
    build_number: latest_testflight_build_number(
        username: ENV['APPLE_ID_USERNAME'],
        app_identifier: "mdb.SwiftyPick"
    ) + 1
) # This is to prevent being rejected by AppStoreConnect for submitting multiple builds with same number
# You have to add your `APPLE_ID_USERNAME` to Github Secrets to make this worj
build_app(
    export_options: {
        provisioningProfiles: { 
            "mdb.SwiftyPick" => "SwiftyPick AppStore"
        }
    }
)
upload_to_testflight(
    skip_waiting_for_build_processing: true,
    changelog: changelog_from_git_commits(
        commits_count: 5,
        pretty: "- %s",
        merge_commit_filtering: "exclude_merges"
    ) # This is to set the `What to test?` notes to the latest 5 commit messages
)
end
```
2. Create a new github action to upload the app to testflight:
```yml
name: Upload build to Testflight

on:
  push:
    branches: main

jobs:
  upload-build:
    runs-on: macos-latest
    env:
      APP_STORE_CONNECT_API_KEY_KEY_ID: ${{ secrets.APP_STORE_CONNECT_API_KEY_KEY_ID }}
      APP_STORE_CONNECT_API_KEY_ISSUER_ID: ${{ secrets.APP_STORE_CONNECT_API_KEY_ISSUER_ID }}
      APP_STORE_CONNECT_API_KEY_KEY: ${{ secrets.APP_STORE_CONNECT_API_KEY_KEY }}
      MATCH_PASSWORD: ${{ secrets.MATCH_PASSWORD }}
      MATCH_GIT_BASIC_AUTHORIZATION: ${{ secrets.MATCH_GIT_BASIC_AUTHORIZATION }} 
    steps:
      - name: Checkout
        uses: actions/checkout@v2
        with:
          fetch-depth: '5' # This is to allow the CI to fetch the latest 5 commits
      - name: Upload to Testflight
        run: fastlane distribute_to_testflight
```

That's it! If you follow the steps above you should be able to start distributing your app to testflight automatically on every push to the `main` branch using Github Actions and Fastlane 🤖 🚀

## Further reading

* [Mastering Github Actions for iOS](https://medium.com/@przemek.jablonski/mastering-github-actions-for-ios-54660d1997f5)
