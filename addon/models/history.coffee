`import DS from 'ember-data'`
`import {RelateableMixin} from 'autox'`
`import Timestamps from '../mixins/timestamps'`

History = DS.Model.extend RelateableMixin, Timestamps,
  recordableId: DS.attr "string",
    description: "The polymorphic id of an object that supports histories"
  type: DS.attr 'string',
    label: "Event Type"
    description: "A macro that facilitates search and filtering of events"
    display: ["show", "index"]
  name: DS.attr 'string',
    label: "Event Name"
    description: "The name of this historical event"
    display: ["show", "index"]
  message: DS.attr 'string',
    label: "Event Summary"
    description: "A message visible to the user that explain to the user the significance of this event"
    display: ["show"]
  scheduledAt: DS.attr 'moment',
    label: "Evented Scheduled For"
    description: "The expected UTC time for when this event is planned to happen"
    display: ["show"]
  happenedAt: DS.attr 'moment',
    label: "Evented Happened At"
    description: "The actual UTC time when this event took place"
    display: ["show"]
  mentionedType: DS.attr 'string',
    label: "Mentioned Type"
    description: "The factory name of model object which is related to this event"
    display: ["show"]
  mentionedId: DS.attr 'string',
    label: "Mentioned id"
    description: "The id model object which is related to this event"
    display: ["show"]

`export default History`
