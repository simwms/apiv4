`import moment from 'moment'`
`import _ from 'lodash/lodash'`
{merge} = _

class History
  identify = (model) ->
    mentionedType: model.constructor.modelName
    mentionedId: model.id
    type: "pair"
    scheduledAt: moment()
    happenedAt: moment()

  @truckEnterSite = ({truck, gate}) ->
    core = 
      name: "truck-enter-site"
      message: "truck arrived at entrance"
    truck: merge core, identify(truck)
    gate: merge core, identify(gate)
  @truckExitSite = ({truck, gate}) ->
    core = 
      name: "truck-exit-site"
      message: "truck has left the site"
    truck: merge core, identify(truck)
    gate: merge core, identify(gate)
  @truckEnterScale = ({truck, scale}) ->
    core = 
      name: "truck-enter-scale"
      message: "truck arrived at weight station"
    truck: merge core, identify(truck)
    scale: merge core, identify(scale)
  @truckExitScale = ({truck, scale}) ->
    core = 
      name: "truck-exit-scale"
      message: "truck has left weight station"
    truck: merge core, identify(truck)
    scale: merge core, identify(scale)
  @truckEnterDock = ({truck, dock}) ->
    core = 
      name: "truck-enter-dock"
      message: "truck arrived at dock"
    truck: merge core, identify(truck)
    dock: merge core, identify(dock)
  @truckExitDock = ({truck, dock}) ->
    core = 
      name: "truck-exit-dock"
      message: "truck has departed from the dock"
    truck: merge core, identify(truck)
    dock: merge core, identify(dock)
`export default History`
