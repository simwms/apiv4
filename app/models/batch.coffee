`import DS from 'ember-data'`
`import {RelateableMixin, action} from 'autox'`
`import Realtime from 'apiv4/mixins/realtime'`
`import Paranoia from 'apiv4/mixins/paranoia'`
`import Timestamps from 'apiv4/mixins/timestamps'`
`import History from 'apiv4/utils/history'`
`import Historical from 'autox/mixins/historical'`
`import Ember from 'ember'`

{RSVP} = Ember

Model = DS.Model.extend Timestamps, Realtime, Paranoia, RelateableMixin, Historical,
  pickupAppointment: action "click",
    label: "Mark for Pick Up"
    description: "Mark this load to be picked up by the current appointment"
    display: ["show"]
    when: sync "fsm.prev", -> @fsm.wasA "appointment"
    setup: ({fsm}) -> fsm.get "prev"
    (appointment) -> History.createWith "appointmentPickupBatch", {appointment, batch: @}
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
    defaultValue: (router) -> router.modelFor "manager.appointments.appointment"
  pictures: DS.hasMany "picture", async: true

  didCreate: ->
    @get "inAppointment"
    .then (appointment) =>
      History.createWith "appointmentDropoffBatch", {appointment, batch: @}

`export default Model`