`import Ember from 'ember'`
`import DS from 'ember-data'`
`import moment from 'moment'`
`import {RelateableMixin} from 'autox'`
`import Realtime from 'apiv4/mixins/realtime'`
`import Timestamps from 'apiv4/mixins/timestamps'`
`import Historical from 'apiv4/mixins/historical'`
`import History from 'apiv4/utils/history'`

{get, RSVP, getWithDefault} = Ember

Model = DS.Model.extend Timestamps, RelateableMixin, Realtime, Historical,
  type: "tile"
  tileType: "truck"
  tileImage: "assets/image/truck.png"
  width: 0.5
  height: 0.5

  appointment: DS.belongsTo "appointment",
    label: "Appointment"
    description: "The appointment for which this truck is here to fulfill"
    among: (router) -> router.modelFor("manager").appointments
    defaultValue: (router) -> router.modelFor("manager.appointments.appointment")
    modify: ["new"]
    async: true

  pictures: DS.hasMany "picture", async: true

  didCreate: ->
    @get "appointment"
    .then (appointment) =>
      rParams = History.truckEnterSite truck: @, appointment: appointment
      RSVP.hash
        truck: @relate("histories").associate(rParams.truck).save()
        appointment: appointment.relate("histories").associate(rParams.appointment).save()

`export default Model`