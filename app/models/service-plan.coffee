`import DS from 'ember-data'`
`import {RelateableMixin} from 'autox'`

`import Timestamps from 'apiv4/mixins/timestamps'`
Model = DS.Model.extend Timestamps, RelateableMixin,
  
  amount: DS.attr "number"
  
  cells: DS.attr "number"
  
  currency: DS.attr "string"
  
  deletedAt: DS.attr "moment"
  
  description: DS.attr "string"
  
  docks: DS.attr "number"
  
  employees: DS.attr "number"

  interval: DS.attr "string"
  
  intervalCount: DS.attr "number"
  
  name: DS.attr "string"
  
  presentation: DS.attr "string"
  
  scales: DS.attr "number"
  
  stripePlanId: DS.attr "string"

`export default Model`