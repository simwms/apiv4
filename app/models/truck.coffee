`import DS from 'ember-data'`
`import {RelateableMixin} from 'autox'`

Model = DS.Model.extend RelateableMixin,
  
  goliveAt: DS.attr "moment"
  
  insertedAt: DS.attr "moment"
  
  unliveAt: DS.attr "moment"
  
  updatedAt: DS.attr "moment"
  

  
  histories: DS.hasMany "history", async: true
  
  pictures: DS.hasMany "picture", async: true
  

`export default Model`