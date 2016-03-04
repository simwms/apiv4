`import Ember from 'ember'`
`import DS from 'ember-data'`
`import moment from 'moment'`
`import {Mixins, action, computed} from 'autox'`
`import History from 'apiv4/utils/history'`

{computedTask} = computed
{Relateable, Realtime, Timestamps, Historical, Multiaction} = Mixins
OnsiteNames = ["truck-enter-site", "truck-exit-dock", "truck-exit-scale"]

Actions =
  arriveOnsite: action "click",
    label: "Mark Truck Arrival"
    description: "Inform the warehouse that this truck has just arrived on-site"
    display: ["show"]
    when: computedTask "model.histories.length", ->
      @get("model.histories").then Ember.isEmpty
    ->
      {appointment} = yield from action.needs "appointment"
      History.persistWith "truckEnterSite", {appointment, truck: @}
  departOnsite: action "click",
    label: "Mark Truck Departed"
    description: "Inform the warehouse that this truck has completed its business and has physically departed"
    display: ["show"]
    when: History.latestWas OnsiteNames
    ->
      yield return @get("appointment").then (appointment) =>
        History.persistWith "truckExitSite", {appointment, truck: @}
  arriveDock: action "click",
    label: "Truck Arrive at Dock"
    description: "Tell the system that this truck has physically arrived at this dock"
    display: ["show"]
    when: History.latestWas OnsiteNames
    -> 
      {dock} = yield from action.needs "dock"
      History.persistWith "truckEnterDock", {dock, truck: @}
  departDock: action "click",
    label: "Truck Leaves Dock"
    description: "Inform the system that this truck has physically departed from this dock"
    display: ["show"]
    when: History.latestWas "truck-enter-dock"
    ->
      yield return @latestMentioned().then (dock) =>
        History.persistWith "truckExitDock", {dock, truck: @}
  arriveScale: action "click",
    label: "Truck Arrive at Scale"
    description: "Tell the system that this truck has physically arrived at this weight station"
    display: ["show"]
    when: History.latestWas OnsiteNames
    ->
      {scale} = yield from action.needs "scale"
      History.persistWith "truckEnterScale", {scale, truck: @}
  departScale: action "click",
    label: "Truck Leaves Scales"
    description: "Inform the system that this truck has physically departed from the weight station"
    display: ["show"]
    when: History.latestWas "truck-enter-scale"
    ->
      yield return @latestMentioned().then (scale) =>
        History.persistWith "truckExitScale", {scale, truck: @}

Model = DS.Model.extend Timestamps, Relateable, Realtime, Historical, Multiaction, Actions,
  type: "tile"
  tileType: "truck"
  tileImage: "assets/image/truck.png"
  width: 0.5
  height: 0.5

  appointment: DS.belongsTo "appointment",
    priority: 1
    label: "Appointment"
    description: "The appointment for which this truck is here to fulfill"
    display: ["show", "index"]
    async: true

  pictures: DS.hasMany "picture", async: true

  didCreate: ->
    @get "appointment"
    .then (appointment) =>
      @arriveOnsite(appointment)

`export default Model`