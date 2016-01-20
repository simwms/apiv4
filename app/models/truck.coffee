`import DS from 'ember-data'`
`import {RelateableMixin} from 'autox'`
`import moment from 'moment'`

Model = DS.Model.extend RelateableMixin,
  
  goliveAt: DS.attr "moment", defaultValue: -> moment()
  
  insertedAt: DS.attr "moment"
  
  unliveAt: DS.attr "moment"
  
  updatedAt: DS.attr "moment"
  
  appointment: DS.belongsTo "appointment", async: true
  
  histories: DS.hasMany "history", async: true
  
  pictures: DS.hasMany "picture", async: true
  

`export default Model`