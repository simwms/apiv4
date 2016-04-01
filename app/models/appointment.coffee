`import DS from 'ember-data'`
`import {Mixins} from 'autox'`
`import History from 'apiv4/utils/history'`
`import Query from 'autox/utils/query'`
makeQuery = (name) ->
  new Query()
  .filterBy("name", "i~", name)
  .orderBy("name")
  .pageBy 
    limit: 25
    offset: 0
{Relateable, Realtime, Timestamps, Historical, Multiaction, Paranoia} = Mixins
Model = DS.Model.extend Paranoia, Timestamps, Relateable, Realtime, Historical, Multiaction,
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
    search: (name) -> 
      @store.query "company", makeQuery(name).toParams()
    among: -> @store.findAll "company"
    accessor: "appointment-company-field"
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