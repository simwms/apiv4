`import DS from 'ember-data'`
`import {RelateableMixin} from 'autox'`
`import TileCore from 'apiv4/mixins/tile-core'`
`import Timestamps from 'apiv4/mixins/timestamps'`
`import Historical from 'apiv4/mixins/historical'`

Model = DS.Model.extend Timestamps, RelateableMixin, TileCore, Historical,
  cameras: DS.hasMany "camera", async: true
  batches: DS.hasMany "batches", async: true

`export default Model`