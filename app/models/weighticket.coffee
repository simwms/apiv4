`import DS from 'ember-data'`
`import {RelateableMixin} from 'autox'`

Model = DS.Model.extend RelateableMixin,
  
  arrivePounds: DS.attr "number"
  
  departPounds: DS.attr "number"
  
  externalReference: DS.attr "string"
  
  goliveAt: DS.attr "moment"
  
  insertedAt: DS.attr "moment"
  
  licensePlate: DS.attr "string"
  
  notes: DS.attr "string"
  
  unliveAt: DS.attr "moment"
  
  updatedAt: DS.attr "moment"
  

  

`export default Model`