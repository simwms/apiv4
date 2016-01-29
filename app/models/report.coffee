`import DS from 'ember-data'`
`import {RelateableMixin} from 'autox'`
`import Ember from 'ember'`
{computed: {alias}} = Ember

`import Timestamps from 'apiv4/mixins/timestamps'`
Model = DS.Model.extend Timestamps, RelateableMixin,
  goliveAt: DS.attr "moment"
  unliveAt: DS.attr "moment"

  startAt: alias "goliveAt"
  finishAt: alias "unliveAt"  

`export default Model`