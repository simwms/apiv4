`import DS from 'ember-data'`
`import {RelateableMixin} from 'autox'`
`import Ember from 'ember'`
`import Timestamps from 'apiv4/mixins/timestamps'`
`import Realtime from 'apiv4/mixins/realtime'`
{computed: {alias}} = Ember

Model = DS.Model.extend Timestamps, RelateableMixin, Realtime,
  startAt: alias "goliveAt"
  finishAt: alias "unliveAt"  

`export default Model`