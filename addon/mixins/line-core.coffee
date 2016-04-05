`import Ember from 'ember'`
`import DS from 'ember-data'`
`import Importance from 'autox/utils/importance'`
{computed} = Ember
{alias, oneWay} = computed

LineCoreMixin = Ember.Mixin.create
  x: DS.attr "number",
    priority: Importance.Nonessential
    defaultValue: 0
    label: "Grid X Position"
    description: "The horizontal coordinate of grid position from the top left corner"
    display: ["show"]
    modify: ["new", "edit"]
  
  y: DS.attr "number", 
    priority: Importance.Nonessential
    defaultValue: 0
    label: "Grid Y Position"
    description: "The vertical coordinate of grid position from the top left corner"
    display: ["show"]
    modify: ["new", "edit"]

  a: DS.attr "number",
    priority: Importance.Pointless
    label: "Rotation angle"
    description: "the degree of rotation of a tile about its center"
    display: ["show"]
    modify: ["new", "edit"]

  points: DS.attr "points",
    priority: Importance.Pointless
    label: "Points"
    description: "A comma seprated collection of points linearly interpolated to be the line"
    display: ["show"]
    modify: ["new", "edit"]
  
  lineName: DS.attr "string",
    priority: Importance.GoodToHave
    label: "Line Name"
    description: "The specified name of the this line"
    display: ["show"]
    modify: ["new", "edit"]

  lineType: oneWay "constructor.modelName"
  type: alias "lineType"
  ghostType: "2point"

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