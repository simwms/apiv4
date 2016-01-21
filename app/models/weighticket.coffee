`import DS from 'ember-data'`
`import {RelateableMixin} from 'autox'`
`import moment from 'moment'`

Model = DS.Model.extend RelateableMixin,
  arrivePounds: DS.attr "number"
  departPounds: DS.attr "number"
  externalReference: DS.attr "string"
  licensePlate: DS.attr "string"
  notes: DS.attr "string"
  appointment: DS.belongsTo "appointment", async: true

  goliveAt: DS.attr "moment", defaultValue: -> moment()
  unliveAt: DS.attr "moment"
  insertedAt: DS.attr "moment"
  updatedAt: DS.attr "moment"

`export default Model`