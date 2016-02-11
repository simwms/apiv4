`import DS from 'ember-data'`
`import {RelateableMixin, action, about} from 'autox'`
`import TileCore from 'apiv4/mixins/tile-core'`
`import Timestamps from 'autox/mixins/timestamps'`
`import Historical from 'autox/mixins/historical'`
`import History from 'apiv4/utils/history'`
`import {_computed} from 'autox/utils/xdash'`
{computedPromise: sync} = _computed
Actions =
  arriveDock: action "click",
    priority: 2
    label: "Dock Truck"
    description: "Dock a truck at this current dock"
    display: ["show"]
    when: sync "fsm.prev", -> @fsm.wasA "truck"
    setup: ({fsm}) -> fsm.get("prev")
    (truck) ->
      History.createWith "truckEnterDock", {truck, dock: @}

  departDock: action "click",
    priority: 2
    label: "Send Away Truck"
    description: "After a truck has been loaded or unloaded, sends away the truck, and frees up this dock"
    display: ["show"]
    when: sync "model.histories", -> 
      @get("model")?.latestHistoryHas("name", "truck-enter-dock")
    setup: -> @latestMentioned()
    (truck) ->
      History.createWith "truckExitDock", {truck, dock: @}

Model = DS.Model.extend Timestamps, RelateableMixin, TileCore, Historical, Actions,
  cameras: DS.hasMany "camera", async: true

about Model,
  label: "Dock Number."
  description: "Docks are places where workers may unload or load material out of and into trucks"
`export default Model`