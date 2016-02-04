`import DS from 'ember-data'`
`import moment from 'moment'`
`import {RelateableMixin} from 'autox'`
`import Realtime from 'apiv4/mixins/realtime'`
`import Timestamps from 'apiv4/mixins/timestamps'`
`import Historical from 'apiv4/mixins/historical'`
`import History from 'apiv4/utils/history'`

Actions =
  arriveOnsite: (appointment) ->
    History.createWith "truckEnterSite", {appointment, truck: @}
  departOnsite: (appointment) ->
    History.createWith "truckExitSite", {appointment, truck: @}
  arriveDock: (dock) ->
    History.createWith "truckEnterDock", {dock, truck: @}
  departDock: (dock) ->
    History.createWith "truckExitDock", {dock, truck: @}
  arriveScale: (scale) ->
    History.createWith "truckEnterScale", {scale, truck: @}
  departScale: (scale) ->
    History.createWith "truckExitScale", {scale, truck: @}

Model = DS.Model.extend Timestamps, RelateableMixin, Realtime, Historical, Actions,
  type: "tile"
  tileType: "truck"
  tileImage: "assets/image/truck.png"
  width: 0.5
  height: 0.5

  appointment: DS.belongsTo "appointment",
    label: "Appointment"
    description: "The appointment for which this truck is here to fulfill"
    among: (router) -> router.modelFor("manager").appointments
    defaultValue: (router) -> router.modelFor("manager.appointments.appointment")
    modify: ["new"]
    async: true

  pictures: DS.hasMany "picture", async: true

  didCreate: ->
    @get "appointment"
    .then (appointment) =>
      @arriveOnsite(appointment)

`export default Model`