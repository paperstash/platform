window.PaperStash.API =
  BASE:     window.location.origin.replace('app', 'api')
  HOST:     window.location.hostname.replace('app', 'api')
  PROTOCOL: window.location.protocol.slice(0, -1)

if PaperStash.environment in ['production']
  PaperStash.API.PROTOCOL = 'https'

if PaperStash.environment in ['development']
  PaperStash.API.BASE = 'http://localhost:4001'
  PaperStash.API.HOST = 'localhost'
  PaperStash.API.PROTOCOL = 'http'

module.exports = PaperStash.API
