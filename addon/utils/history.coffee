`import moment from 'moment'`
`import _ from 'lodash/lodash'`
{merge, mapValues} = _

coreAp = (params, core) ->
  mapValues params, (model) -> merge(core, identify(model))
identify = (model) ->
  mentionedType: model.constructor.modelName
  mentionedId: model.id
  type: "pair"
  scheduledAt: moment()
  happenedAt: moment()
class History
  @appointmentCreated = (appointment) ->
    name: "appointment-created"
    message: "appointment created"
    mentionedId: appointment.id
    mentionedType: "appointment"
    type: "single"
    scheduledAt: moment()
    happenedAt: moment()
  @appointmentPickupBatch = (params) -> # {appointment, batch}
    coreAp params,
      name: "appointment-pickup-batch"
      message: "Load scheduled to be picked up by appointment"
  @appointmentDropoffBatch = (params) -> # {appointment, batch}
    coreAp params,
      name: "appointment-dropoff-batch"
      message: "Load dropped off at warehouse by appointment"
  @truckEnterSite = (params) -> # {truck, appointment}
    coreAp params, 
      name: "truck-enter-site"
      message: "truck arrived on site"
  @truckExitSite = (params) -> # {truck, appointment}
    coreAp params, 
      name: "truck-exit-site"
      message: "truck has left the site"
  @truckEnterScale = (params) -> # {truck, scale}
    coreAp params, 
      name: "truck-enter-scale"
      message: "truck arrived at weight station"
  @truckExitScale = (params) -> # {truck, scale}
    coreAp params, 
      name: "truck-exit-scale"
      message: "truck has left weight station"
  @truckEnterDock = (params) -> # {truck, dock}
    coreAp params, 
      name: "truck-enter-dock"
      message: "truck arrived at dock"
  @truckExitDock = (params) -> # {truck, dock}
    coreAp params, 
      name: "truck-exit-dock"
      message: "truck has departed from the dock"
`export default History`
