`import DS from 'ember-data'`
`import {RelateableMixin} from 'autox'`
`import TileCore from 'apiv4/mixins/tile-core'`
`import Timestamps from 'apiv4/mixins/timestamps'`
Model = DS.Model.extend Timestamps, RelateableMixin, TileCore,
  cameras: DS.hasMany "camera", async: true
  histories: DS.hasMany "history", async: true

`export default Model`