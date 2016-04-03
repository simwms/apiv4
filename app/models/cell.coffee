`import DS from 'ember-data'`
`import {Mixins} from 'autox'`
`import TileCore from 'apiv4/mixins/tile-core'`

{Relateable, Timestamps, Historical, Multiaction} = Mixins
Model = DS.Model.extend Timestamps, Relateable, TileCore, Historical, Multiaction,
  cameras: DS.hasMany "camera", async: true
  batches: DS.hasMany "batches", async: true

`export default Model`