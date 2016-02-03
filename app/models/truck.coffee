`import DS from 'ember-data'`
`import {RelateableMixin} from 'autox'`
`import moment from 'moment'`
`import Realtime from 'apiv4/mixins/realtime'`
`import Timestamps from 'apiv4/mixins/timestamps'`
`import {Macros} from 'ember-cpm'`
`import Ember from 'ember'`
`import History from 'apiv4/utils/history'`
{computedPromise} = Macros
{get, RSVP, getWithDefault} = Ember

Model = DS.Model.extend Timestamps, RelateableMixin, Realtime,
  appointment: DS.belongsTo "appointment",
    label: "Appointment"
    description: "The appointment for which this truck is here to fulfill"
    among: (router) -> router.modelFor("manager").appointments
    defaultValue: (router) -> router.modelFor("manager.appointments.appointment")
    modify: ["new"]
    async: true
  
  histories: DS.hasMany "history", async: true
  
  pictures: DS.hasMany "picture", async: true
  
  type: "tile"
  tileType: "truck"
  tileImage: "assets/image/truck.png"
  width: 0.5
  height: 0.5

  latestHistory: computedPromise "histories.firstObject", ->
    @get "histories"
    .then (histories) ->
      get(histories, "firstObject")
  latestTile: computedPromise "latestHistory.mentionedModel", ->
    getWithDefault(@, "latestHistory.mentionedModel", RSVP.resolve())

  didCreate: ->
    @get "appointment"
    .then (appointment) =>
      rParams = History.truckEnterSite truck: @, appointment: appointment
      RSVP.hash
        truck: @relate("histories").associate(rParams.truck).save()
        appointment: appointment.relate("histories").associate(rParams.appointment).save()

`export default Model`