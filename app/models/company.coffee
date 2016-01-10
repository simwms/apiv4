`import DS from 'ember-data'`
`import {RelateableMixin} from 'autox'`

Model = DS.Model.extend RelateableMixin,
  
  insertedAt: DS.attr "moment"
  
  name: DS.attr "string"
  
  updatedAt: DS.attr "moment"
  

  
  appointments: DS.hasMany "appointment", async: true
  

`export default Model`