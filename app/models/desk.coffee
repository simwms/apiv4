`import DS from 'ember-data'`
`import {RelateableMixin} from 'autox'`

Model = DS.Model.extend RelateableMixin,
  
  a: DS.attr "number"
  
  height: DS.attr "number"
  
  insertedAt: DS.attr "moment"
  
  status: DS.attr "string"
  
  updatedAt: DS.attr "moment"
  
  width: DS.attr "number"
  
  x: DS.attr "number"
  
  y: DS.attr "number"
  
  z: DS.attr "number"
  

  
  cameras: DS.hasMany "camera", async: true
  
  histories: DS.hasMany "history", async: true
  

`export default Model`