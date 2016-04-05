`import Ember from 'ember'`
`import DS from 'ember-data'`
`import moment from 'moment'`
`import {Mixins, action, computed, Importance} from 'autox'`
`import History from 'apiv4/utils/history'`

{computedTask} = computed
{Relateable, Realtime, Timestamps, Historical, Multiaction} = Mixins
OnsiteNames = ["truck-enter-site", "truck-exit-dock", "truck-exit-scale"]

Actions =
  arriveOnsite: action "click",
    priority: Importance.MissionCritical
    label: "Mark Truck Arrival"
    description: "Inform the warehouse that this truck has just arrived on-site"
    display: ["show"]
    when: computedTask "model.histories.length", ->
      @get("model")
      ?.get("histories")
      ?.then (histories) -> 
        Ember.isEmpty histories
    ->
      yield return @get("appointment").then (appointment) =>
        History.createWith "truckEnterSite", {appointment, truck: @}
  departOnsite: action "click",
    priority: Importance.MissionCritical
    label: "Mark Truck Departed"
    description: "Inform the warehouse that this truck has completed its business and has physically departed"
    display: ["show"]
    when: History.latestWas OnsiteNames
    ->
      yield return @get("appointment").then (appointment) =>
        History.createWith "truckExitSite", {appointment, truck: @}
  arriveDock: action "click",
    priority: Importance.MissionCritical
    label: "Truck Arrive at Dock"
    description: "Tell the system that this truck has physically arrived at this dock"
    display: ["show"]
    when: History.latestWas OnsiteNames
    -> 
      {dock} = yield from action.needs "dock"
      History.createWith "truckEnterDock", {dock, truck: @}
  departDock: action "click",
    priority: Importance.MissionCritical
    label: "Truck Leaves Dock"
    description: "Inform the system that this truck has physically departed from this dock"
    display: ["show"]
    when: History.latestWas "truck-enter-dock"
    ->
      yield return @latestMentioned().then (dock) =>
        History.createWith "truckExitDock", {dock, truck: @}
  arriveScale: action "click",
    priority: Importance.MissionCritical
    label: "Truck Arrive at Scale"
    description: "Tell the system that this truck has physically arrived at this weight station"
    display: ["show"]
    when: History.latestWas OnsiteNames
    ->
      {scale} = yield from action.needs "scale"
      History.createWith "truckEnterScale", {scale, truck: @}
  departScale: action "click",
    priority: Importance.MissionCritical
    label: "Truck Leaves Scales"
    description: "Inform the system that this truck has physically departed from the weight station"
    display: ["show"]
    when: History.latestWas "truck-enter-scale"
    ->
      yield return @latestMentioned().then (scale) =>
        History.createWith "truckExitScale", {scale, truck: @}

Model = DS.Model.extend Timestamps, Relateable, Realtime, Historical, Multiaction, Actions,
  type: "tile"
  tileType: "truck"
  tileImage: "assets/image/truck.png"
  width: 0.5
  height: 0.5

  appointment: DS.belongsTo "appointment",
    priority: Importance.Important
    label: "Appointment"
    description: "The appointment for which this truck is here to fulfill"
    display: ["show", "index"]
    async: true

  companyName: DS.attr "string",
    priority: Importance.GoodToHave
    label: "Related Company Name"
    description: "The company who is providing this truck's transportation services"
    display: ["show", "index"]

  company: DS.belongsTo "company",
    priority: Importance.GoodToHave
    label: "Related Company"
    description: "The company who is providing this truck's transportation services"
    modify: ["new", "edit"]
    search: (name) -> 
      @store.query "company", makeQuery(name).toParams()
    among: -> @store.findAll "company"
    accessor: "truck-company-field"
    proxyKey: "name"
    async: true

  pictures: DS.hasMany "picture", async: true

`export default Model`