`import DS from 'ember-data'`
`import {Mixins} from 'autox'`
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
    modify: ["new", "edit"]

  pictures: DS.hasMany "picture", async: true
  

`export default Model`