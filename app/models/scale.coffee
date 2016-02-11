`import DS from 'ember-data'`
`import {RelateableMixin} from 'autox'`
`import TileCore from 'apiv4/mixins/tile-core'`
`import Timestamps from 'apiv4/mixins/timestamps'`
`import Historical from 'autox/mixins/historical'`
`import {_computed} from 'autox/utils/xdash'`
{computedPromise: sync} = _computed
Actions =
  arriveDock: action "click",
    priority: 0
    label: "Truck Arrive at Scale"
    description: "Mark that a truck has arrived at this weight station scale"
    display: ["show"]
    when: sync "fsm.prev", -> @fsm.wasA "truck"
    setup: ({fsm}) -> fsm.get("prev")
    (truck) ->
      History.createWith "truckEnterScale", {truck, scale: @}

  departDock: action "click",
    priority: 0
    label: "Send Away Truck"
    description: "After the current truck has complete its weighing, mark that the truck has left"
    display: ["show"]
    when: sync "model.histories", -> 
      @get("model")?.latestHistoryHas("name", "truck-enter-scale")
    setup: -> @latestMentioned()
    (truck) ->
      History.createWith "truckExitScale", {truck, scale: @}
Model = DS.Model.extend Timestamps, RelateableMixin, TileCore, Historical,
  cameras: DS.hasMany "camera", async: true

`export default Model`