window.PaperStash.API =
  BASE:     window.location.origin.replace('app', 'api')
  HOST:     window.location.hostname.replace('app', 'api')
  PROTOCOL: window.location.protocol.slice(0, -1)

if PaperStash.environment in ['production']
  PaperStash.API.PROTOCOL = 'https'

module.exports = PaperStash.API
