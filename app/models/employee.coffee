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

  pictures: DS.hasMany "picture", async: true

  promoteToAdmin: action "click",
    label: "Promote to Warehouse Admin"
    description: "Enable this employee to access the warehouse admin panel"
    display: ["show"]
    when: equal "model.role", "worker"
    -> 
      @set "role", "admin"
      @save()

  demoteToWorker: action "click",
    label: "Demote to Warehouse Worker"
    description: "Revoke warehouse admin panel access from this employee account"
    display: ["show"]
    when: equal "model.role", "admin"
    ->
      @set "role", "worker"
      @save()

`export default Model`