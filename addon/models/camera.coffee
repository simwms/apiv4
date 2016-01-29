`import DS from 'ember-data'`
`import {RelateableMixin} from 'autox'`
`import Timestamps from '../mixins/timestamps'`

Camera = DS.Model.extend RelateableMixin, Timestamps,
  filmableId: DS.attr 'string',
    description: "The polymorphic id of an object which supports cameras"
  type: DS.attr 'string',
    description: "The type of camera stream used internally to display the video"
  address: DS.attr 'string',
    description: "The URI to the camera stream"

`export default Camera`
