`import Ember from 'ember'`
`import DS from 'ember-data'`

ParanoiaMixin = Ember.Mixin.create
  deletedAt: DS.attr "moment",
    priority: 501
    label: "Deleted At"
    description: "The UTC time when this object was marked deleted in the database"
    display: ["show"]

`export default ParanoiaMixin`