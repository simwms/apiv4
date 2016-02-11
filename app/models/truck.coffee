`import DS from 'ember-data'`
`import moment from 'moment'`
`import {RelateableMixin, action, _x} from 'autox'`
`import Realtime from 'apiv4/mixins/realtime'`
`import Timestamps from 'apiv4/mixins/timestamps'`
`import Historical from 'autox/mixins/historical'`
`import History from 'apiv4/utils/history'`

{computed: {computedPromise: sync}} = _x

OnsiteNames = ["truck-enter-site", "truck-exit-dock", "truck-exit-scale"]
Actions =
  arriveOnsite: (appointment) ->
    History.persistWith "truckEnterSite", {appointment, truck: @}
  departOnsite: action "click",
    label: "Mark Truck Departed"
    description: "Inform the warehouse that this truck has completed its business and has physically departed"
    display: ["show"]
    when: sync "model.histories", -> @get("model").latestHistoryHas("name", OnsiteNames)
    setup: -> @get "appointment"
    (appointment) ->
      History.persistWith "truckExitSite", {appointment, truck: @}
  arriveDock: action "click",
    label: "Truck Arrive at Dock"
    description: "Tell the system that this truck has physically arrived at this dock"
    display: ["show"]
    when: sync "fsm.prev", "model.histories", -> 
      fsm.wasA "dock" and @latestHistoryHas("name", OnsiteNames)
    setup: ({fsm}) -> fsm.get("prev")
    (dock) -> History.persistWith "truckEnterDock", {dock, truck: @}
  departDock: action "click",
    label: "Truck Leaves Dock"
    description: "Inform the system that this truck has physically departed from this dock"
    display: ["show"]
    when: sync "model.histories", -> @get("model").latestHistoryHas("name", "truck-enter-dock")
    setup: -> @latestMentioned()
    (dock) -> History.persistWith "truckExitDock", {dock, truck: @}
  arriveScale: action "click",
    label: "Truck Arrive at Scale"
    description: "Tell the system that this truck has physically arrived at this weight station"
    display: ["show"]
    when: sync "fsm.prev", "model.histories", -> 
      fsm.wasA "scale" and @latestHistoryHas("name", OnsiteNames)
    setup: ({fsm}) -> fsm.get("prev")
    (scale) ->
      History.persistWith "truckEnterScale", {scale, truck: @}
  departScale: action "click",
    label: "Truck Leaves Scales"
    description: "Inform the system that this truck has physically departed from the weight station"
    display: ["show"]
    when: sync "model.histories", -> @get("model").latestHistoryHas "name", "truck-enter-scale"
    setup: -> @latestMentioned()
    (scale) ->
      History.persistWith "truckExitScale", {scale, truck: @}

Model = DS.Model.extend Timestamps, RelateableMixin, Realtime, Historical, Actions,
  type: "tile"
  tileType: "truck"
  tileImage: "assets/image/truck.png"
  width: 0.5
  height: 0.5

  appointment: DS.belongsTo "appointment",
    priority: 1
    label: "Appointment"
    description: "The appointment for which this truck is here to fulfill"
    among: (router) -> router.modelFor("manager").appointments
    defaultValue: (router) -> router.modelFor("manager.appointments.appointment")
    modify: ["new"]
    display: ["show", "index"]
    async: true

  pictures: DS.hasMany "picture", async: true

  didCreate: ->
    @get "appointment"
    .then (appointment) =>
      @arriveOnsite(appointment)

`export default Model`