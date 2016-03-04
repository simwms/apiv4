`import DS from 'ember-data'`
`import {Mixins, action} from 'autox'`
`import TileCore from 'apiv4/mixins/tile-core'`
`import History from 'apiv4/utils/history'`

{Relateable, Realtime, Timestamps, Historical, Multiaction} = Mixins
Actions =
  arriveDock: action "click",
    priority: 0
    label: "Truck Arrive at Scale"
    description: "Mark that a truck has arrived at this weight station scale"
    display: ["show"]
    ->
      {truck} = yield from action.needs "truck"
      History.createWith "truckEnterScale", {truck, scale: @}

  departDock: action "click",
    priority: 0
    label: "Send Away Truck"
    description: "After the current truck has complete its weighing, mark that the truck has left"
    display: ["show"]
    when: History.latestWas("truck-enter-scale")
    ->
      yield return @latestMentioned().then =>
        History.createWith "truckExitScale", {truck, scale: @}

Model = DS.Model.extend Timestamps, Relateable, TileCore, Historical, Actions, Multiaction,
  cameras: DS.hasMany "camera", async: true

`export default Model`