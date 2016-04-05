`import DS from 'ember-data'`
`import Ember from 'ember'`
`import {SessionStateMixin, Importance} from 'autox'`

Session = DS.Model.extend Ember.Evented, SessionStateMixin,
  
  email: DS.attr "string",
    label: "Login Email Address"
    description: "The username identifer used by our system to both send the user email as well as to sign the user in"
    display: ["show"]
    modify: ["new"]
    priority: Importance.VeryImportant
  
  password: DS.attr "string",
    label: "Password"
    description: "The plain-text password associated with this account, used only in account creation"
    modify: ["new"]
    priority: Importance.Important
  
  rememberMe: DS.attr "boolean",
    label: "Remeber Me?"
    description: "Informs the system to maintain a cookie to your session"
    defaultValue: true
  
  rememberToken: DS.attr "string",
    label: "Remember Token"
    description: "An unused replica of the cookie header used to maintain autox xession with the backend"
  
  user: DS.belongsTo "user", async: true
  
  account: DS.belongsTo "account", async: true
  
  employee: DS.belongsTo "employee", async: true
  

`export default Session`