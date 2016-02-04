`import DS from 'ember-data'`
`import Ember from 'ember'`
`import {Macros} from 'ember-cpm'`
{computedPromise} = Macros
{get, RSVP, getWithDefault} = Ember
HistoricalMixin = Ember.Mixin.create
  histories: DS.hasMany "history", async: true
  latestHistory: computedPromise "histories.lastObject", ->
    @get "histories"
    .then (histories) ->
      get(histories, "lastObject")
  latestMentioned: computedPromise "latestHistory.mentionedModel", ->
    getWithDefault(@, "latestHistory.mentionedModel", RSVP.resolve())

`export default HistoricalMixin`
