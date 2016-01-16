`import Adapter from 'autox/adapters/session'`
`import ENV from '../config/environment'`

SessionAdapter = Adapter.extend
  host: ENV.host
  namespace: ENV.namespace
  cookieKey: ENV.cookieKey

`export default SessionAdapter`