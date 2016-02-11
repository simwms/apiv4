`import Ember from 'ember'`
`import DS from 'ember-data'`
`import moment from 'moment'`

RealtimeMixin = Ember.Mixin.create
  goliveAt: DS.attr "moment",
    priority: 50
    label: "Time of Live Arrival"
    description: "The UTC date time when this object is scheduled to go live on-site"
    display: ["show", "index"]
    modify: ["edit", "new"]
    defaultValue: -> moment()
  unliveAt: DS.attr "moment",
    priority: 51
    label: "Time of Completion"
    description: "The UTC date time when this object completes its live onsite work"
    display: ["show"]
    modify: ["edit"]

`export default RealtimeMixin`