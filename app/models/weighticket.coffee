`import DS from 'ember-data'`
`import {RelateableMixin} from 'autox'`
`import moment from 'moment'`

`import Timestamps from 'apiv4/mixins/timestamps'`
Model = DS.Model.extend Timestamps, RelateableMixin,
  arrivePounds: DS.attr "number"
  departPounds: DS.attr "number"
  externalReference: DS.attr "string"
  licensePlate: DS.attr "string"
  notes: DS.attr "string"
  appointment: DS.belongsTo "appointment", async: true

  goliveAt: DS.attr "moment", defaultValue: -> moment()
  unliveAt: DS.attr "moment"


`export default Model`