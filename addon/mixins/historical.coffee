`import DS from 'ember-data'`
`import Ember from 'ember'`
`import {Macros} from 'ember-cpm'`
{computedPromise} = Macros
{get, RSVP, getWithDefault} = Ember
HistoricalMixin = Ember.Mixin.create
  histories: DS.hasMany "history", async: true
  latestHistory: ->
    @get "histories"
    .then (histories) ->
      get(histories, "lastObject")
  latestMentioned: ->
    @latestHistory()
    .then (history) ->
      history?.mentionedModel()

`export default HistoricalMixin`
