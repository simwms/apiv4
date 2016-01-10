`import DS from 'ember-data'`
`import {RelateableMixin} from 'autox'`

Model = DS.Model.extend RelateableMixin,
  
  deletedAt: DS.attr "moment"
  
  description: DS.attr "string"
  
  goliveAt: DS.attr "moment"
  
  insertedAt: DS.attr "moment"
  
  quantity: DS.attr "string"
  
  unliveAt: DS.attr "moment"
  
  updatedAt: DS.attr "moment"
  

  
  histories: DS.hasMany "history", async: true
  
  pictures: DS.hasMany "picture", async: true
  

`export default Model`