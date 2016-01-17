`import DS from 'ember-data'`
`import {RelateableMixin} from 'autox'`

Model = DS.Model.extend RelateableMixin,
  
  a: DS.attr "number"
  
  insertedAt: DS.attr "moment"
  
  lineName: DS.attr "string"
  
  points: DS.attr "points"
  
  updatedAt: DS.attr "moment"
  
  x: DS.attr "number"
  
  y: DS.attr "number"
  

  

`export default Model`