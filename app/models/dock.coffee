`import DS from 'ember-data'`
`import {Mixins, action, about, computed} from 'autox'`
`import TileCore from 'apiv4/mixins/tile-core'`
`import History from 'apiv4/utils/history'`

{computedTask: sync} = computed
{Relateable, Realtime, Timestamps, Historical, Multiaction, Paranoia} = Mixins
Actions =
  arriveDock: action "click",
    priority: 2
    label: "Dock Truck"
    description: "Dock a truck at this current dock"
    display: ["show"]
    when: History.latestWasnt("truck-enter-dock")
    ->
      {truck} = yield from action.needs "truck"
      History.createWith "truckEnterDock", {truck, dock: @}

  departDock: action "click",
    priority: 2
    label: "Send Away Truck"
    description: "After a truck has been loaded or unloaded, sends away the truck, and frees up this dock"
    display: ["show"]
    when: History.latestWas("truck-enter-dock")
    ->
      yield return @latestMentioned().then (truck) =>
        History.createWith "truckExitDock", {truck, dock: @}

Model = DS.Model.extend Timestamps, Relateable, TileCore, Historical, Actions, Multiaction,
  cameras: DS.hasMany "camera", async: true

about Model,
  label: "Dock Number."
  description: "Docks are places where workers may unload or load material out of and into trucks"
`export default Model`