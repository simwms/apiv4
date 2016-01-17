`import Ember from 'ember'`
`import DS from 'ember-data'`
{computed} = Ember
{alias, oneWay} = computed

LineCoreMixin = Ember.Mixin.create
  x: DS.attr "number", defaultValue: 0
  y: DS.attr "number", defaultValue: 0
  a: DS.attr "number"
  points: DS.attr "points"
  lineName: DS.attr "string"

  lineType: oneWay "constructor.modelName"
  type: alias "lineType"

  origin: computed "x", "y",
    get: ->
      x: @get "x"
      y: @get "y"

  thickness: computed "type",
    get: ->
      switch @get "type"
        when "road" then 0.3
        else 0

`export default LineCoreMixin`