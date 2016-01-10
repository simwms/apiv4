`import DS from 'ember-data'`
`import Ember from 'ember'`
`import {SessionStateMixin} from 'autox'`

Session = DS.Model.extend Ember.Evented, SessionStateMixin,
  
  email: DS.attr "string"
  
  password: DS.attr "string"
  
  rememberMe: DS.attr "boolean"
  
  rememberToken: DS.attr "string"
  

  
  user: DS.belongsTo "user", async: true
  
  account: DS.belongsTo "account", async: true
  
  employee: DS.belongsTo "employee", async: true
  

`export default Session`