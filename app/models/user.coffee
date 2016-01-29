`import DS from 'ember-data'`
`import {RelateableMixin} from 'autox'`

`import Timestamps from 'apiv4/mixins/timestamps'`
Model = DS.Model.extend Timestamps, RelateableMixin,
  
  email: DS.attr "string"
  
  forgetAt: DS.attr "moment"

  password: DS.attr "string"
  
  passwordHash: DS.attr "string"
  
  recoveryHash: DS.attr "string"
  
  rememberToken: DS.attr "string"
  
  stripeCustomerId: DS.attr "string"

  accounts: DS.hasMany "account", async: true
  
  employees: DS.hasMany "employee", async: true
  

`export default Model`