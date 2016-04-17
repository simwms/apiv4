`import DS from 'ember-data'`
`import {Mixins} from 'autox'`
`import TileCore from 'apiv4/mixins/tile-core'`

{Relateable, Timestamps, Historical, Multiaction} = Mixins
Model = DS.Model.extend Timestamps, Relateable, TileCore, Historical, Multiaction,
  cameras: DS.hasMany "camera", async: true
  batches: DS.hasMany "batches", 
    label: "Storaged Loads"
    description: "The batch loads stored at this storage cell location"
    display: ["show"]
    async: true
    link: true

`export default Model`