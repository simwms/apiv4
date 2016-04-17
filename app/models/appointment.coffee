`import DS from 'ember-data'`
`import {Mixins, Importance, QueryUtils, action} from 'autox'`
`import History from 'apiv4/utils/history'`
`import moment from 'moment'`
makeQuery = (name) ->
  new QueryUtils()
  .filterBy("name", "i~", name)
  .orderBy("name")
  .pageBy 
    limit: 25
    offset: 0
{Relateable, Realtime, Timestamps, Historical, Multiaction, Paranoia} = Mixins
Model = DS.Model.extend Paranoia, Timestamps, Relateable, Realtime, Historical, Multiaction,
  priceNumber: DS.attr "number",
    priority: Importance.Important
    step: 0.000001
    label: "Price per Unit"
    description: "The agreed unit price value of this appointment for your reference"
    modify: ["new", "edit"]
    display: ["show"]
  priceUnits: DS.attr "string",
    priority: Importance.Important
    label: "Units of Price"
    description: "The agreed units of price, for example: \"cents / pound\", \"dollars / metric ton\""
    modify: ["new", "edit"]
    display: ["show"]
  priceNotes: DS.attr "string",
    priority: Importance.Important
    label: "Additional Price Notes"
    description: "Any additional references you'd like to comment about the price"
    modify: ["new", "edit"]
    display: ["show"]
  quantityNumber: DS.attr "number",
    priority: Importance.Important
    step: 0.000001
    label: "Quantity Value"
    description: "The expected numeric quantity of this appointment in units of the denominator of price"
    modify: ["new", "edit"]
    display: ["show"]
  description: DS.attr "string",
    priority: Importance.GoodToHave
    label: "Material Description"
    description: "Extra notes regarding this appointment"
    modify: ["new", "edit"]
    display: ["show"]
  externalReference: DS.attr "string",
    priority: Importance.Important
    label: "External Reference Number"
    description: "In case you use another appointment management system"
    display: ["show", "index"]
    modify: ["new", "edit"]
  
  companyName: DS.attr "string",
    priority: Importance.VeryImportant
    label: "Related Company Name"
    description: "The company associated with this appointment"
    display: ["show", "index"]

  company: DS.belongsTo "company",
    label: "Related Company"
    description: "The associated company with whom this appointment is for"
    modify: ["new", "edit"]
    search: (name) -> 
      @store.query "company", makeQuery(name).toParams()
    among: -> @store.findAll "company"
    accessor: "appointment-company-field"
    proxyKey: "name"
    async: true

  unliveAppointment: action "click",
    label: "Mark Appointment Complete"
    description: "Designate this appointment is complete and place it into the archive"
    display: ["show"]
    priority: Importance.VeryImportant
    ->
      @set "unliveAt", moment()
      yield return @save()
  pickupBatch: action "click",
    label: "Select Load to Pick-up"
    description: "Designate a currently onsite load to be picked up by this appointment"
    display: ["show"]
    priority: Importance.HeavyConsequences
    ->
      {batch} = yield from action.need "batch"
      batch.set "outAppointment", @
      batch.set "unliveAt", moment()
      @batch.save().then =>
        createWith "appointmentPickupBatch", {appointment, batch: @}

  inBatches: DS.hasMany "batch",
    label: "Imported Loads"
    description: "The batch loads that were brought into this warehouse by this appointment"
    inverse: "inAppointment"
    display: ["show"]
    async: true
    link: true
  outBatches: DS.hasMany "batch",
    label: "Exported Loads"
    description: "The batch loads that were taken out of this warehouse by this appointment"
    inverse: "outAppointment"
    display: ["show"]
    async: true
    link: true

  pictures: DS.hasMany "picture", async: true
  truck: DS.belongsTo "truck", 
    label: "Appointment Truck"
    description: "The truck affliated with this appointment"
    display: ["show"]
    async: true
    link: true
  weighticket: DS.belongsTo "weighticket", 
    label: "Appointment Weight Ticket"
    description: "The weight data of the truck affliated with this appointment"
    display: ["show"]
    async: true
    link: true
  
  didCreate: ->
    @_super arguments...
    History.createWith "appointmentCreated", appointment: @

`export default Model`