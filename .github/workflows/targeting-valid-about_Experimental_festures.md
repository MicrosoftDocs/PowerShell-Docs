# This workflow verifies that an author submitting a pull request to the live
# branch is authorized to do so; only users with maintainer or admin rights may
# target the live branch directly.
name: Authorization
on:
  pull_request_target:
    branches:
      - live
permissions:
  contents: read
jobs:
  Test:
    name: Check Branch Permissions
    runs-on: windows-latest
    defaults:
      run:
        shell: pwsh
    steps:
      - name: Checkout Repository
        id: checkout_repo
        uses: actions/checkout@v4
      - name: Authorized to Target Live Branch?
        uses: ./.github/actions/verification/authorization/v1
        with:
          token: ${{ github.token }}
