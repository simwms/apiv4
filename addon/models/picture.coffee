`import DS from 'ember-data'`
`import {RelateableMixin} from 'autox'`

Picture = DS.Model.extend RelateableMixin, {
  imageableId: DS.attr 'string'
  type: DS.attr 'string'
  link: DS.attr 'string'
  insertedAt: DS.attr 'moment'
  updatedAt: DS.attr 'moment'
}

`export default Picture`
