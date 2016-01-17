`import Ember from 'ember'`
`import DS from 'ember-data'`

TimestampsMixin = Ember.Mixin.create
  insertedAt: DS.attr "moment"
  updatedAt: DS.attr "moment"

`export default TimestampsMixin`