`import DS from 'ember-data'`
`import {RelateableMixin} from 'autox'`

`import Timestamps from 'autox/mixins/timestamps'`
Model = DS.Model.extend Timestamps, RelateableMixin,
  
  email: DS.attr "string",
    label: "Login Email Address"
    description: "The username identifer used by our system to both send the user email as well as to sign the user in"
    display: ["show"]
    modify: ["new"]
  
  forgetAt: DS.attr "moment",
    label: "Remember Me Until..."
    description: "The date after which the cookie session will expire and require the user to re-login"

  password: DS.attr "string",
    label: "Password"
    description: "The plain-text password associated with this account, used only in account creation"
    modify: ["new"]
  
  passwordHash: DS.attr "string",
    label: "Password Hash"
    description: "The server-assigned bcrypt-encrypted string that represents both salt and password"
  
  recoveryHash: DS.attr "string",
    label: "Recovery Hash"
    description: "Unique string to be used in recovery of the user's password. Not yet implemented"
  
  rememberToken: DS.attr "string",
    label: "Remember Token"
    description: "An unused replica of the cookie header used to maintain autox xession with the backend"
  
  stripeCustomerId: DS.attr "string",
    label: "Stripe Customer Id"
    description: "The id string given to us by our payment provider Stripe which serves to enable payment"

  accounts: DS.hasMany "account", 
    label: "My Warehouses"
    description: "These are the warehouse accounts created by (and possibly paid for) by you and where you are the superadmin"
    display: ["show"]
    async: true
    link: true
  
  employees: DS.hasMany "employee",
    label: "Warehouse Employment Badge"
    description: "You are an employee at, and can log into, these warehouses"
    display: ["show"]
    inverse: "user"
    async: true
    link: true

  unconfirmedEmployees: DS.hasMany "employee", 
    label: "Warehouse Employment Requests"
    description: "You have these unopened invitations to work at other warehouse"
    inverse: "unconfirmedUser"
    display: ["show"]
    async: true
    link: true
  

`export default Model`