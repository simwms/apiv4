`import DS from 'ember-data'`
`import {RelateableMixin} from 'autox'`

Model = DS.Model.extend RelateableMixin,
  
  confirmed: DS.attr "boolean"
  
  insertedAt: DS.attr "moment"
  
  name: DS.attr "string"
  
  role: DS.attr "string"
  
  updatedAt: DS.attr "moment"
  

  
  histories: DS.hasMany "history", async: true
  
  pictures: DS.hasMany "picture", async: true
  

`export default Model`