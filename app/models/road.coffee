`import DS from 'ember-data'`
`import {RelateableMixin} from 'autox'`
`import LineCore from 'apiv4/mixins/line-core'`
`import Timestamps from 'apiv4/mixins/timestamps'`
Model = DS.Model.extend Timestamps, RelateableMixin, LineCore, {}

`export default Model`