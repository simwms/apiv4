`import Adapter from 'autox/adapters/session'`
`import ENV from '../config/environment'`

SessionAdapter = Adapter.extend
  host: ENV.host
  namespace: ENV.namespace

  handleResponse: (status, headers, payload) ->
    console.log headers
    @_super arguments...

`export default SessionAdapter`