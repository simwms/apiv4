`import DS from 'ember-data'`
`import {RelateableMixin} from 'autox'`
`import moment from 'moment'`

`import Timestamps from 'apiv4/mixins/timestamps'`
Model = DS.Model.extend Timestamps, RelateableMixin,
  
  goliveAt: DS.attr "moment", defaultValue: -> moment()

  unliveAt: DS.attr "moment"

  appointment: DS.belongsTo "appointment", async: true
  
  histories: DS.hasMany "history", async: true
  
  pictures: DS.hasMany "picture", async: true
  

`export default Model`