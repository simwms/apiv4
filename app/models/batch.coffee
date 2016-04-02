`import DS from 'ember-data'`
`import moment from 'moment'`
`import Autox from 'autox'`
`import History from 'apiv4/utils/history'`

{createWith} = History
{Mixins, action} = Autox
{Relateable, Realtime, Timestamps, Historical, Multiaction, Paranoia} = Mixins

Model = DS.Model.extend Timestamps, Realtime, Paranoia, Relateable, Historical, Multiaction,
  moveToCell: action "click",
    label: "Move Load to Storage Cell"
    description: "Mark that this batch has been moved to the selected storage cell"
    display: ["show"]
    ->
      {cell} = yield from action.needs "cell"
      @set "cell", cell
      @save().then =>
        createWith "batchMoveCell", {cell, batch: @}

  pickupAppointment: action "click",
    label: "Mark for Pick Up"
    description: "Mark this load to be picked up by the current appointment"
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
    display: ["show"]
    async: true

  outAppointment: DS.belongsTo "appointment",
    label: "Pick Up Appointment"
    description: "The appointment which will pick up this load from our warehouse"
    display: ["show"]
    async: true
    inverse: "outBatches"
  inAppointment: DS.belongsTo "appointment",
    label: "Drop Off Appointment"
    description: "The appointment which dropped this load off into our warehouse"
    display: ["show"]
    async: true
    inverse: "inBatches"

  pictures: DS.hasMany "picture", async: true

  didCreate: ->
    @get "inAppointment"
    .then (appointment) =>
      History.createWith "appointmentDropoffBatch", {appointment, batch: @}

`export default Model`