`import Adapter from 'autox/adapters/application'`
`import ENV from '../config/environment'`

AppAdapter = Adapter.extend
  host: ENV.host
  namespace: ENV.namespace

`export default AppAdapter`
