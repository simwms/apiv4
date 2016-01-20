`import DS from 'ember-data'`
`import {RelateableMixin} from 'autox'`

Model = DS.Model.extend RelateableMixin,
  
  deletedAt: DS.attr "moment"
  insertedAt: DS.attr "moment"
  updatedAt: DS.attr "moment"
  
  description: DS.attr "string"
  externalReference: DS.attr "string"
  goliveAt: DS.attr "moment"
  unliveAt: DS.attr "moment"
  
  batches: DS.hasMany "batch", async: true
  
  company: DS.belongsTo "company", async: true
  
  histories: DS.hasMany "history", async: true
  
  pictures: DS.hasMany "picture", async: true
  
  truck: DS.belongsTo "truck", async: true
  
  weighticket: DS.belongsTo "weighticket", async: true
  

`export default Model`