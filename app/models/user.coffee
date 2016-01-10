`import DS from 'ember-data'`
`import {RelateableMixin} from 'autox'`

Model = DS.Model.extend RelateableMixin,
  
  email: DS.attr "string"
  
  forgetAt: DS.attr "moment"
  
  insertedAt: DS.attr "moment"
  
  password: DS.attr "string"
  
  passwordHash: DS.attr "string"
  
  recoveryHash: DS.attr "string"
  
  rememberToken: DS.attr "string"
  
  stripeCustomerId: DS.attr "string"
  
  updatedAt: DS.attr "moment"
  

  
  accounts: DS.hasMany "account", async: true
  
  employees: DS.hasMany "employee", async: true
  

`export default Model`