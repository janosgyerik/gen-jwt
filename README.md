Generate JWT tokens
===================

Generate JWT tokens (based on [this GitHub guide][gen-jwt-github-guide]), and other related goodies, POCs.

Requirements:

- Python3
- Bash

Setup: run the script:

    ./scripts/setup.sh

This creates a `venv`, where it installs Python3 dependencies.

GitHub POCs
-----------

To make GitHub API calls authenticated with an App requires a JWT access token.

### Creating a Pull Request comment

Setup:

- Create a GitHub App (most fields can be dummies)
  - Grant **Read & write** permissions on **Pull requests**
  - Note the App ID, near the top of the **General** settings page
  - Generate a private key, called a "pem" file, save it somewhere safe

- Authorize the app on a repository: go to the public page of the app, click **Configure**, and select the organization to install, with allowed repositories

- Get the app's installation ID in the repository: go to **Settings / Integrations & services**, click **Configure** of the app, look at the URL, and note the number in the last path segment

Create an access token for this repo with:

    ./create-access-token.sh app_id path_to_pem installation_id

This will output a newly generated JWT token (which you don't need directly), and an access token. Store the latter in a shell variable `token`, to use in API calls.

Examples:

    # create a comment
    curl -s -XPOST -H "Authorization: Bearer $token" \
        "https://api.github.com/repos/$owner/$repo/issues/$pr/comments" \
        -d@comment.json

    # list comment ids and texts
    curl -s "https://api.github.com/repos/$owner/$repo/issues/$pr/comments" \
        | jq '.[] | (.id, .body)'

    # update a comment
    curl -s -XPATCH -H "Authorization: Bearer $token" \
        "https://api.github.com/repos/$owner/$repo/issues/comments/$comment_id" \
        -d@update.json

    # delete a comment
    curl -s -XDELETE -H "Authorization: Bearer $token" \
        "https://api.github.com/repos/$owner/$repo/issues/comments/$comment_id"

Where `comment.json` and `update.json` can have content like this:

    {
        "body": "some comment"
    }

[gen-jwt-github-guide]: https://developer.github.com/apps/building-github-apps/authenticating-with-github-apps/#authenticating-as-a-github-app
