`import DS from 'ember-data'`
`import {RelateableMixin} from 'autox'`
`import Realtime from 'apiv4/mixins/realtime'`
`import Paranoia from 'apiv4/mixins/paranoia'`
`import Timestamps from 'apiv4/mixins/timestamps'`

Model = DS.Model.extend Paranoia, Timestamps, RelateableMixin, Realtime,  
  description: DS.attr "string",
    description: "Extra notes regarding this appointment"
    modify: ["new", "edit"]
    display: ["show"]
  externalReference: DS.attr "string",
    label: "External Reference Number"
    description: "In case you use another appointment management system"
    display: ["show", "index"]
    modify: ["new", "edit"]
  
  batches: DS.hasMany "batch", async: true
  histories: DS.hasMany "history", async: true
  pictures: DS.hasMany "picture", async: true
  
  company: DS.belongsTo "company",
    label: "Related Company"
    description: "The associated company with whom this appointment is for"
    display: ["show", "index"]
    modify: ["new"]
    among: (_, store) -> store.findAll "company"
    proxyKey: "name"
    async: true
  
  truck: DS.belongsTo "truck", async: true
  
  weighticket: DS.belongsTo "weighticket", async: true
  

`export default Model`