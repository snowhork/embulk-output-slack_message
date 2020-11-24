# Slack Message output plugin for Embulk

TODO: Write short description here and embulk-output-slack_message.gemspec file.

## Overview

* **Plugin type**: output
* **Load all or nothing**: no
* **Resume supported**: no
* **Cleanup supported**: yes

## Configuration

- **option1**: description (integer, required)
- **option2**: description (string, default: `"myvalue"`)
- **option3**: description (string, default: `null`)

## Example

```yaml
out:
  type: slack_message
  option1: example1
  option2: example2
```


## Build

```
$ rake
```
