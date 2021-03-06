`import DS from 'ember-data'`
`import {RelateableMixin} from 'autox'`
`import TileCore from 'apiv4/mixins/tile-core'`
`import Timestamps from 'autox/mixins/timestamps'`
`import Historical from 'autox/mixins/historical'`
Model = DS.Model.extend Timestamps, RelateableMixin, TileCore, Historical,
  cameras: DS.hasMany "camera", async: true

`export default Model`