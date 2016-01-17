`import DS from 'ember-data'`
`import {RelateableMixin} from 'autox'`

Camera = DS.Model.extend RelateableMixin, {
  filmableId: DS.attr 'string'
  type: DS.attr 'string'
  address: DS.attr 'string'
  insertedAt: DS.attr 'moment'
  updatedAt: DS.attr 'moment'
}

`export default Camera`
