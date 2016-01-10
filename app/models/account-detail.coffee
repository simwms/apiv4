`import DS from 'ember-data'`
`import {RelateableMixin} from 'autox'`

Model = DS.Model.extend RelateableMixin,
  
  cellCount: DS.attr "string"
  
  dockCount: DS.attr "string"
  
  employeeCount: DS.attr "string"
  
  insertedAt: DS.attr "moment"
  
  scaleCount: DS.attr "string"
  
  updatedAt: DS.attr "moment"
  

  

`export default Model`