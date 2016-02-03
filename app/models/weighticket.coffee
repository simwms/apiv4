`import DS from 'ember-data'`
`import {RelateableMixin} from 'autox'`
`import moment from 'moment'`
`import Realtime from 'apiv4/mixins/realtime'`
`import Timestamps from 'apiv4/mixins/timestamps'`
Model = DS.Model.extend Timestamps, RelateableMixin, Realtime,
  arrivePounds: DS.attr "number",
    label: "Initial Weight (pounds)"
    description: "Trucks are weighed on entering the warehouse"
    display: ["show"]
    modify: ["new", "edit"]
  departPounds: DS.attr "number",
    label: "Terminal Weight (pounds)"
    description: "Trucks are weighed upon exiting the warehouse"
    display: ["show"]
    modify: ["new", "edit"]
  externalReference: DS.attr "string",
    label: "External Reference Number"
    description: "If you have an external weight-ticket tracking system, you can input its value here"
    display: ["show"]
    modify: ["new", "edit"]
  licensePlate: DS.attr "string",
    label: "Truck License Plate"
    description: "The license plate of the truck being weighed"
    display: ["show"]
    modify: ["new", "edit"]
  notes: DS.attr "string",
    label: "Additional Notes"
    description: "Anything else notable about this truck or this appointment weight ticket"
    display: ["show"]
    modify: ["new", "edit"]
  appointment: DS.belongsTo "appointment",
    label: "Related Appointment"
    description: "The appointment for which this weight ticket is related to"
    defaultValue: (router) -> router.modelFor "manager.appointments.appointment"
    async: true
    display: ["show", "index"]

Model.aboutMe =
  label: "Weighticket for Appointment"
  description: "Weightickets are assigned at on-site weight stations"
  display: ["show", "index"]
  routeName: "manager.weighticket.index"
`export default Model`