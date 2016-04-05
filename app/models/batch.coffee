`import DS from 'ember-data'`
`import moment from 'moment'`
`import Autox from 'autox'`
`import History from 'apiv4/utils/history'`

{createWith} = History
{Mixins, action, Importance} = Autox
{Relateable, Realtime, Timestamps, Historical, Multiaction, Paranoia} = Mixins

Model = DS.Model.extend Timestamps, Realtime, Paranoia, Relateable, Historical, Multiaction,
  moveToCell: action "click",
    label: "Move Load to Storage Cell"
    description: "Mark that this batch has been moved to the selected storage cell"
    priority: Importance.HeavyConsequences
    display: ["show"]
    ->
      {cell} = yield from action.needs "cell"
      @set "cell", cell
      @save().then =>
        createWith "batchMoveCell", {cell, batch: @}

  pickupAppointment: action "click",
    label: "Mark for Pick Up"
    description: "Mark this load to be picked up by the current appointment"
    priority: Importance.HeavyConsequences
    display: ["show"]
    ->
      {appointment} = yield from action.needs "appointment"
      @set "outAppointment", appointment
      @set "unliveAt", moment()
      @save().then =>
        createWith "appointmentPickupBatch", {appointment, batch: @}
  description: DS.attr "string",
    label: "Quality Description"
    description: "Extra notes regarding this load"
    priority: Importance.Nonessential
    modify: ["new", "edit"]
    display: ["show"]

  quantityUnits: DS.attr "string",
    label: "Units of this Load"
    description: "For example, 'pounds', 'boxes', or 'kilograms'"
    priority: Importance.GoodToHave
    modify: ["new", "edit"]
    display: ["show"]
  quantityNumber: DS.attr "number",
    label: "Quantity Value"
    description: "The numeric value of this load batch"
    priority: Importance.GoodToHave
    modify: ["new", "edit"]
    display: ["show"]
  quantity: DS.attr "string",
    label: "Quantity Description"
    description: "The qualitative description of quantity of this load"
    priority: Importance.GoodToHave
    modify: ["new", "edit"]
    display: ["show"]
  
  cell: DS.belongsTo "cell",
    label: "Storage Cell"
    description: "The on-site storage cell where this load will be stored"
    priority: Importance.Nonessential
    display: ["show"]
    async: true

  outAppointment: DS.belongsTo "appointment",
    label: "Pick Up Appointment"
    description: "The appointment which will pick up this load from our warehouse"
    priority: Importance.Nonessential
    display: ["show"]
    async: true
    inverse: "outBatches"

  inAppointment: DS.belongsTo "appointment",
    label: "Drop Off Appointment"
    description: "The appointment which dropped this load off into our warehouse"
    priority: Importance.Nonessential
    display: ["show"]
    async: true
    inverse: "inBatches"

  pictures: DS.hasMany "picture", async: true

  didCreate: ->
    @get "inAppointment"
    .then (appointment) =>
      History.createWith "appointmentDropoffBatch", {appointment, batch: @}

`export default Model`