`import DS from 'ember-data'`
`import {RelateableMixin} from 'autox'`

`import Timestamps from 'apiv4/mixins/timestamps'`
Model = DS.Model.extend Timestamps, RelateableMixin,
  
  confirmed: DS.attr "boolean"

  name: DS.attr "string"
  
  role: DS.attr "string"

  histories: DS.hasMany "history", async: true
  
  pictures: DS.hasMany "picture", async: true
  

`export default Model`