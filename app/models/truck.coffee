`import DS from 'ember-data'`
`import {RelateableMixin} from 'autox'`
`import moment from 'moment'`
`import Realtime from 'apiv4/mixins/realtime'`
`import Timestamps from 'apiv4/mixins/timestamps'`
`import {Macros} from 'ember-cpm'`
`import Ember from 'ember'`
`import History from 'apiv4/utils/history'`
{computedPromise} = Macros
{get, RSVP} = Ember

Model = DS.Model.extend Timestamps, RelateableMixin, Realtime,
  appointment: DS.belongsTo "appointment",
    label: "Appointment"
    description: "The appointment for which this truck is here to fulfill"
    among: (router) -> router.modelFor("manager").appointments
    defaultValue: (router) -> router.modelFor("manager.appointment")
    modify: ["new"]
    async: true
  
  histories: DS.hasMany "history", async: true
  
  pictures: DS.hasMany "picture", async: true
  
  type: "tile"
  tileType: "truck"
  tileImage: "assets/image/truck.png"
  width: 0.5
  height: 0.5
  origin: computedPromise "lastTile", ->
    @get "lastTile"
    ?.get "origin"
  lastTile: computedPromise "histories", ->
    @get "histories"
    .then (histories) ->
      get(histories, "firstObject")
    .then (history) ->
      get(history, "mentionedModel")

  didCreate: ->
    @get "appointment"
    .then (appointment) =>
      rParams = History.truckEnterSite truck: @, appointment: appointment
      RSVP.hash
        truck: @relate("histories").associate(rParams.truck).save()
        appointment: appointment.relate("histories").associate(rParams.appointment).save()

`export default Model`