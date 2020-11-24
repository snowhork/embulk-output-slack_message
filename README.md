# Slack Message output plugin for Embulk

TODO: Write short description here and embulk-output-slack_message.gemspec file.

## Overview

* **Plugin type**: output
* **Load all or nothing**: no
* **Resume supported**: no
* **Cleanup supported**: yes

## Configuration

- **webhook_url**: description (string, required)
- **title**: description (string)

## Example

```yaml
out:
  type: slack_message
  title: "New Message"
  webhook_url: "https://hooks.slack.com/services/TZZZZZZ/BYYYYYY/XXXXXXXXXXXXXXXXX"
```


## Build

```
$ rake
```
