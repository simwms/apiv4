`import DS from 'ember-data'`
`import {RelateableMixin} from 'autox'`
`import Timestamps from '../mixins/timestamps'`

Picture = DS.Model.extend RelateableMixin, Timestamps,
  imageableId: DS.attr 'string',
    description: "The polymorphic id of something that can have pictures"
  type: DS.attr 'string',
    description: "The picture type specification used in encoding"
  link: DS.attr 'string',
    description: "The external uri link to the picture"

`export default Picture`
