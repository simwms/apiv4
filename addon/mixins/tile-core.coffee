`import Ember from 'ember'`
`import DS from 'ember-data'`

{computed} = Ember
{oneWay} = computed

TileCoreMixin = Ember.Mixin.create
  type: "tile"
  tileName: DS.attr "string",
    priority: 50
    label: "Tile Name"
    description: "The specified name of the this tile"
    display: ["show"]
    modify: ["new", "edit"]
  status: DS.attr "string",
    priority: 10
    label: "Status"
    description: "The realtime value of the physical status of this tile"
    display: ["show", "index"]
    modify: ["edit"]
  x: DS.attr "number", 
    priority: 50
    defaultValue: 0
    label: "Grid X Position"
    description: "The horizontal coordinate of grid position from the top left corner"
    display: ["show"]
    modify: ["new", "edit"]
  
  y: DS.attr "number", 
    priority: 50
    defaultValue: 0
    label: "Grid Y Position"
    description: "The vertical coordinate of grid position from the top left corner"
    display: ["show"]
    modify: ["new", "edit"]

  a: DS.attr "number",
    priority: 50
    label: "Rotation angle"
    description: "the degree of rotation of a tile about its center"
    display: ["show"]
    modify: ["new", "edit"]
  z: DS.attr "number",
    priority: 50
    label: "Z-Position"
    description: "The currently unsupported coordinate for height out of the screen"
  width: DS.attr "number", 
    description: "The length of a tile in the X-direction in grid coordinates"
    defaultValue: 1
  height: DS.attr "number",
    description: "The length of a tile in the Y-direction in grid coordinates"
    defaultValue: 1

  tileType: oneWay "constructor.modelName"

  origin: computed "x", "y", "a",
    get: ->
      x: @get "x"
      y: @get "y"
      a: @get "a"

  iconText: computed "tileType",
    get: ->
      String.fromCharCode switch @get "tileType"
        when "barn" then 0xf239 # subway
        when "dock" then 0xf0d1 # truck
        when "road" then 0xf018 # road
        when "warehouse", "cell" then 0xf1b3 # cubes
        when "desk" then 0xf108 # desktop
        when "entrance" then 0xf090 # sign-in
        when "exit" then 0xf08b # sign-out
        when "scale" then 0xf24e # balance-scale
        else 0xf059 # question-circle

`export default TileCoreMixin`
