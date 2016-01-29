`import DS from 'ember-data'`
`import {RelateableMixin} from 'autox'`

`import Timestamps from 'apiv4/mixins/timestamps'`
Model = DS.Model.extend Timestamps, RelateableMixin,
  
  cellCount: DS.attr "string"
  
  dockCount: DS.attr "string"
  
  employeeCount: DS.attr "string"

  scaleCount: DS.attr "string"

`export default Model`