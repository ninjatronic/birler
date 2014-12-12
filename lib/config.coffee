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
      severity: 4
  timestamps:
    shown: true
    color: 'grey'
  diffs:
    shown: true
    color: 'cyan'
  render:
    joiner: ',\n  '
    indent: '  '
    padJoin: ['\n  ', '\n']
