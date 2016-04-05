`import DS from 'ember-data'`
`import {Mixins, Importance} from 'autox'`
`import moment from 'moment'`

{Relateable, Timestamps, Realtime} = Mixins
Model = DS.Model.extend Timestamps, Relateable, Realtime,
  arrivePounds: DS.attr "number",
    priority: Importance.Important
    label: "Initial Weight (pounds)"
    description: "Trucks are weighed on entering the warehouse"
    display: ["show"]
    modify: ["new", "edit"]
  departPounds: DS.attr "number",
    priority: Importance.Important
    label: "Terminal Weight (pounds)"
    description: "Trucks are weighed upon exiting the warehouse"
    display: ["show"]
    modify: ["new", "edit"]
  externalReference: DS.attr "string",
    priority: Importance.GoodToHave
    label: "External Reference Number"
    description: "If you have an external weight-ticket tracking system, you can input its value here"
    display: ["show"]
    modify: ["new", "edit"]
  licensePlate: DS.attr "string",
    priority: Importance.Nonessential
    label: "Truck License Plate"
    description: "The license plate of the truck being weighed"
    display: ["show"]
    modify: ["new", "edit"]
  notes: DS.attr "string",
    priority: Importance.Nonessential
    label: "Additional Notes"
    description: "Anything else notable about this truck or this appointment weight ticket"
    display: ["show"]
    modify: ["new", "edit"]
  appointment: DS.belongsTo "appointment",
    priority: Importance.Nonessential
    label: "Related Appointment"
    description: "The appointment for which this weight ticket is related to"
    async: true
    display: ["show", "index"]

Model.aboutMe =
  priority: Importance.Important
  label: "Weighticket for Appointment"
  description: "Weightickets are assigned at on-site weight stations"
  display: ["show", "index"]
  routeName: "manager.weighticket.index"
`export default Model`