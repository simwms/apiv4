`import DS from 'ember-data'`
`import {RelateableMixin} from 'autox'`
`import moment from 'moment'`
`import Realtime from 'apiv4/mixins/realtime'`
`import Timestamps from 'apiv4/mixins/timestamps'`
`import {Macros} from 'ember-cpm'`
`import Ember from 'ember'`
{computedPromise} = Macros
{get} = Ember
DefaultTruckOrigin = -> x: 0, y: 0, a: 0
Model = DS.Model.extend Timestamps, RelateableMixin, Realtime,
  appointment: DS.belongsTo "appointment",
    label: "Appointment"
    description: "The appointment for which this truck is here to fulfill"
    among: (router) -> router.modelFor("manager.appointments")
    async: true
  
  histories: DS.hasMany "history", async: true
  
  pictures: DS.hasMany "picture", async: true
  
  type: "tile"
  tileType: "truck"
  tileImage: "assets/image/truck.png"
  width: 0.5
  height: 0.5
  origin: computedPromise "histories", ->
    @get "histories"
    .then (histories) ->
      get(histories, "firstObject")
    .then (history) ->
      get(history, "mentionedModel")
    .then (tile) ->
      get tile, "origin"


`export default Model`