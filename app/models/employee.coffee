`import Ember from 'ember'`
`import DS from 'ember-data'`
`import Autox from 'autox'`
{computed: {equal}} = Ember
{Mixins, action} = Autox
{Timestamps, Relateable, Historical} = Mixins
Model = DS.Model.extend Timestamps, Relateable, Historical,  
  confirmed: DS.attr "boolean",
    label: "Employee Confirmed?"
    description: "Confirmed employee accounts are properly connected to an user"
    display: ["show"]

  email: DS.attr "string",
    label: "Employee Email"
    description: "The email address of the employee you wish to invite to access your warehouse account"
    display: ["show", "index"]
    modify: ["new", "edit"]

  name: DS.attr "string",
    label: "Employee Name"
    description: "The name of the employee"
    display: ["show", "index"]
    modify: ["new", "edit"]
  
  role: DS.attr "string",
    label: "Employee Job Role"
    description: "The job the employee is assigned at this warehouse"
    display: ["show", "index"]
    modify: ["new"]
    defaultValue: "worker"
    among: ["worker", "admin"]

  account: DS.belongsTo "account",
    label: "Warehouse Account"
    description: "The warehouse account where this employee works"
    display: ["show"]
    proxyKey: "name"

  user: DS.belongsTo "user",
    label: "User Account"
    description: "The user account associate with this warehouse employee"
    async: true

  unconfirmedUser: DS.belongsTo "user",
    label: "Unconfirmed User Account"
    description: "The possibly nonexistent user for which this warehouse employee object would be associated with once that account is confirmed"
    async: true

  pictures: DS.hasMany "picture", async: true

  promoteToAdmin: action "click",
    label: "Promote to Warehouse Admin"
    description: "Enable this employee to access the warehouse admin panel"
    display: ["show"]
    when: equal "model.role", "worker"
    -> 
      @set "role", "admin"
      yield return @save()

  demoteToWorker: action "click",
    label: "Demote to Warehouse Worker"
    description: "Revoke warehouse admin panel access from this employee account"
    display: ["show"]
    when: equal "model.role", "admin"
    ->
      @set "role", "worker"
      yield return @save()

`export default Model`