`import DS from 'ember-data'`
`import {RelateableMixin} from 'autox'`

`import Timestamps from 'apiv4/mixins/timestamps'`
Model = DS.Model.extend Timestamps, RelateableMixin,
  name: DS.attr "string",
    label: "Company Name"
    description: "The name of the company"
    display: ["show", "index"]
    modify: ["new", "edit"]
  appointments: DS.hasMany "appointment", async: true
  
`export default Model`