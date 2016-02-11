`import DS from 'ember-data'`
`import {RelateableMixin} from 'autox'`
`import Realtime from 'autox/mixins/realtime'`
`import Paranoia from 'autox/mixins/paranoia'`
`import Timestamps from 'autox/mixins/timestamps'`
`import Historical from 'autox/mixins/historical'`
`import History from 'apiv4/utils/history'`
Model = DS.Model.extend Paranoia, Timestamps, RelateableMixin, Realtime, Historical,
  description: DS.attr "string",
    label: "Material Description"
    description: "Extra notes regarding this appointment"
    modify: ["new", "edit"]
    display: ["show"]
  externalReference: DS.attr "string",
    label: "External Reference Number"
    description: "In case you use another appointment management system"
    display: ["show", "index"]
    modify: ["new", "edit"]
  
  company: DS.belongsTo "company",
    label: "Related Company"
    description: "The associated company with whom this appointment is for"
    display: ["show", "index"]
    modify: ["new", "edit"]
    among: (_, store) -> store.findAll "company"
    proxyKey: "name"
    async: true

  inBatches: DS.hasMany "batch", 
    inverse: "inAppointment"
    async: true
  outBatches: DS.hasMany "batch", 
    inverse: "outAppointment"
    async: true

  pictures: DS.hasMany "picture", async: true
  truck: DS.belongsTo "truck", async: true
  weighticket: DS.belongsTo "weighticket", async: true
  
  didCreate: ->
    @_super arguments...
    History.createWith "appointmentCreated", appointment: @

`export default Model`