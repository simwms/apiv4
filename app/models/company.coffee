`import DS from 'ember-data'`
`import {RelateableMixin} from 'autox'`

`import Timestamps from 'apiv4/mixins/timestamps'`
Model = DS.Model.extend Timestamps, RelateableMixin,

  name: DS.attr "string"

  appointments: DS.hasMany "appointment", async: true
  

`export default Model`