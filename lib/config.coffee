module.exports =
  color: 'white'
  styles: []
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
      color:  'yellow'
      severity: 2
    info:
      color:  'cyan'
      severity: 3
    debug:
      color:  'grey'
      styles: ['dim']
      severity: 4
  timestamps:
    shown: true
    format: 'dddd, MMMM Do YYYY, h:mm:ss a'
  diffs:
    shown: true
  render:
    joiner: ',\n  '
    indent: '  '
    padJoin: ['\n  ', '\n']
