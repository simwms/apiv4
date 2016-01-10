`import DS from 'ember-data'`
`import {RelateableMixin} from 'autox'`

Model = DS.Model.extend RelateableMixin,
  
  deletedAt: DS.attr "moment"
  
  insertedAt: DS.attr "moment"
  
  name: DS.attr "string"
  
  stripeSource: DS.attr "string"
  
  stripeSubscriptionId: DS.attr "string"
  
  timezone: DS.attr "string"
  
  updatedAt: DS.attr "moment"
  

  

`export default Model`