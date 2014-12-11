# birler

> The little logger that could

## Installation

```
npm install --save git://github.com/ninjatronic/birler.git
```

## Usage

**NB:** Much or all of this is unimplemented - since this is still pre-release.

You can configure birler before use, but it is preconfigured with a nice set of
defaults.

```coffeescript
birler = require 'birler'
birler
  levelEnvironmentVariable: 'LEVEL'
  levels:
    fatal:
      color: 'red'
      styles: ['bold']
      severity: 0
    error:
      color:  'red'
      severity: 1
    warn:
      color:  'orange'
      severity: 2
    info:
      color:  'blue'
      severity: 3
    debug:
      color:  'grey'
      styles: ['dim']
      severity: 4
  timestamps:
    shown: true
    format: 'dddd, MMMM Do YYYY, h:mm:ss a'
    fatal:
      shown: true
      format: 'dddd, MMMM Do YYYY, h:mm:ss a'
    error:
      shown: true
      format: 'dddd, MMMM Do YYYY, h:mm:ss a'
    # etc
  diffs:
    shown: true
    fatal:
      shown: true
    error:
      shown: true
    # etc
  render:
    joiner: ',\n  '
    indent: '  '
    padJoin: ['\n  ', '\n']
    fatal:
      joiner: ',\n  '
      indent: '  '
      padJoin: ['\n  ', '\n']
    error:
      joiner: ',\n  '
      indent: '  '
      padJoin: ['\n  ', '\n']
    # etc


```

Log directly with birler, or create a labelled logger for nicer output.

```coffeescript
birler = require 'birler'

birler.debug 'a debug message from an unnamed source'

logger = birler 'http'

logger.debug 'a debug message'
logger.error 'an error message'
# etc
```

Birler returns promises, for use in promise chains.

```coffeescript
birler = require 'birler'
request = require 'request'
Promise = require 'bluebird'

Promise.promisifyAll request
logger = birler 'statusChecker'

request.getAsync 'https://myService.com/status'
  .tap logger.debug
  .then processStatusResult

processStatusResult = () ->
  # ...

```

Birler runs at `info` level by default, to set the log level, use an environment
variable. To avoid conflicts, you can configure the environment variable to use
in the configuration object.

```
LEVEL=warn node ./myModule.js
```
