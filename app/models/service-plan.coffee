`import DS from 'ember-data'`
`import {RelateableMixin} from 'autox'`

Model = DS.Model.extend RelateableMixin,
  
  amount: DS.attr "number"
  
  cells: DS.attr "number"
  
  currency: DS.attr "string"
  
  deletedAt: DS.attr "moment"
  
  description: DS.attr "string"
  
  docks: DS.attr "number"
  
  employees: DS.attr "number"
  
  insertedAt: DS.attr "moment"
  
  interval: DS.attr "string"
  
  intervalCount: DS.attr "number"
  
  name: DS.attr "string"
  
  presentation: DS.attr "string"
  
  scales: DS.attr "number"
  
  stripePlanId: DS.attr "string"
  
  updatedAt: DS.attr "moment"
  

  

`export default Model`