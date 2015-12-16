#!/usr/bin/env bats

source lib/assert.bash
source deploy.sh --source-only

@test 'option: -v, --verbose' {
	assert that `parse_args -v && echo $verbose` = "true"
	assert that `parse_args --verbose && echo $verbose` = "true"
}
@test 'option: -e, --allow-empty' {
	assert that `parse_args -e && echo $allow_empty` = "true"
	assert that `parse_args --allow-empty && echo $allow_empty` = "true"
}
@test 'option: -m, --message' {
	skip # Check fails if arg/var value has spaces in it.
	assert that `parse_args -m "a message" && echo $commit_message` = "a message"
	assert that `parse_args --message "a message" && echo $commit_message` = "a message"
}
@test 'option: -n, --no-hash' {
	assert that `parse_args -n && echo $append_hash` = "false"
	assert that `parse_args --no-hash && echo $append_hash` = "false"
}
@test 'option: -c, --config-file' {
	skip # No var to test yet.
}

# Script's default settings.
@test 'script default: default_username' {
	assert that `parse_args && echo $default_username` = "deploy.sh"
}
@test 'script default: default_email' {
	skip # Needs a value to check against.
	assert that `parse_args && echo $default_email` = ""
}
@test 'script default: deploy_directory' {
	assert that `parse_args && echo $deploy_directory` = "dist"
}
@test 'script default: deploy_branch' {
	assert that `parse_args && echo $deploy_branch` = "gh-pages"
}
@test 'script default: repo' {
	assert that `parse_args && echo $repo` = "origin"
}

