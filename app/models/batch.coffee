`import DS from 'ember-data'`
`import {RelateableMixin} from 'autox'`
`import Realtime from 'apiv4/mixins/realtime'`
`import Paranoia from 'apiv4/mixins/paranoia'`
`import Timestamps from 'apiv4/mixins/timestamps'`
Model = DS.Model.extend Timestamps, Realtime, Paranoia, RelateableMixin,  
  description: DS.attr "string",
    label: "Quality Description"
    description: "Extra notes regarding this load"
    modify: ["new", "edit"]
    display: ["show"]

  quantity: DS.attr "string",
    label: "Quantity"
    description: "The amount of stuff inside this load"
    modify: ["new", "edit"]
    display: ["show"]
  
  histories: DS.hasMany "history", async: true
  
  pictures: DS.hasMany "picture", async: true
  
  cell: DS.belongsTo "cell",
    label: "Storage Cell"
    description: "The onsite storage cell where this batch will be stored"
    display: ["show"]
    modify: ["edit"]
    among: (_, store) -> store.peekAll "cell"
    async: true

`export default Model`