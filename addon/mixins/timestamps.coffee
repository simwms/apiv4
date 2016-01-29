`import Ember from 'ember'`
`import DS from 'ember-data'`

TimestampsMixin = Ember.Mixin.create
  insertedAt: DS.attr "moment",
    label: "Created At"
    description: "The UTC time when this object was first inserted into the database"
    display: ["show"]
  updatedAt: DS.attr "moment",
    label: "Updated At"
    description: "The UTC time when this object was last updated to the database"
    display: ["show"]
`export default TimestampsMixin`