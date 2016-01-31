`import DS from 'ember-data'`
`import {RelateableMixin} from 'autox'`
`import Realtime from 'apiv4/mixins/realtime'`
`import Paranoia from 'apiv4/mixins/paranoia'`
`import Timestamps from 'apiv4/mixins/timestamps'`
Model = DS.Model.extend Timestamps, Realtime, Paranoia, RelateableMixin,  
  description: DS.attr "string",
    label: "Quality Description"
    description: "Extra notes regarding this load"
    modify: ["new", "edit"]
    display: ["show"]

  quantity: DS.attr "string",
    label: "Quantity"
    description: "The amount of stuff inside this load"
    modify: ["new", "edit"]
    display: ["show"]
  
  cell: DS.belongsTo "cell",
    label: "Storage Cell"
    description: "The on-site storage cell where this load will be stored"
    among: (_, store) -> store.findAll "cell"
    display: ["show"]
    modify: ["edit"]
    async: true

  appointment: DS.belongsTo "appointment",
    label: "Drop Off Appointment"
    description: "The appointment which dropped this load off into our warehouse"
    display: ["show"]
    async: true
    defaultValue: (router) -> router.modelFor "manager.appointment"
  histories: DS.hasMany "history", async: true
  
  pictures: DS.hasMany "picture", async: true

`export default Model`