`import DS from 'ember-data'`
`import {RelateableMixin} from 'autox'`

History = DS.Model.extend RelateableMixin, {
  recordableId: DS.attr "string"
  permalink: DS.attr 'string'
  type: DS.attr 'string'
  name: DS.attr 'string'
  message: DS.attr 'string'
  scheduledAt: DS.attr 'moment'
  happenedAt: DS.attr 'moment'
  mentionedType: DS.attr 'string'
  mentionedId: DS.attr 'string'
  insertedAt: DS.attr 'moment'
  updatedAt: DS.attr 'moment'
}

`export default History`
