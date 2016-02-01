`import DS from 'ember-data'`
`import {RelateableMixin} from 'autox'`
`import TileCore from 'apiv4/mixins/tile-core'`
`import Timestamps from 'apiv4/mixins/timestamps'`
`import {Macros} from 'ember-cpm'`
{computedPromise} = Macros
Model = DS.Model.extend Timestamps, RelateableMixin, TileCore,
  cameras: DS.hasMany "camera", async: true
  histories: DS.hasMany "history", async: true

  truck: computedPromise "histories.firstObject.name", ->
    @get "histories"
    .then (histories) ->
      histories?.get("firstObject")
    .then (history) ->
      if history?.get("name") is "truck-enter-dock"
        history.get "mentionedModel"

`export default Model`