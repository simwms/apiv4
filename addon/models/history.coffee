`import DS from 'ember-data'`
`import {RelateableMixin, virtual} from 'autox'`
`import Timestamps from '../mixins/timestamps'`
`import Ember from 'ember'`
{RSVP} = Ember
History = DS.Model.extend RelateableMixin, Timestamps,
  recordableId: DS.attr "string",
    description: "The polymorphic id of an object that supports histories"
  type: DS.attr 'string',
    label: "Event Type"
    description: "A macro that facilitates search and filtering of events"
  name: DS.attr 'string',
    label: "Event Name"
    description: "The name of this historical event"
  message: DS.attr 'string',
    label: "Event Summary"
    description: "A message visible to the user that explain to the user the significance of this event"
  scheduledAt: DS.attr 'moment',
    label: "Evented Scheduled For"
    description: "The expected UTC time for when this event is planned to happen"
  happenedAt: DS.attr 'moment',
    label: "Evented Happened At"
    description: "The actual UTC time when this event took place"
  mentionedType: DS.attr 'string',
    label: "Mentioned Type"
    description: "The factory name of model object which is related to this event"
  mentionedId: DS.attr 'string',
    label: "Mentioned id"
    description: "The id model object which is related to this event"

  summary: virtual "string",
    label: "Event Summary"
    description: "Just the quick gist of this history event"
    display: ["index"]
    apply "message", "scheduledAt", (message, scheduledAt) ->
      "#{scheduledAt.format('lll')} - #{message}"

  mentionedModel: ->
    type = @get "mentionedType"
    id = @get "mentionedId"
    return RSVP.resolve() if isBlank(id) or isBlank(type)
    @store.findRecord type, id

`export default History`
