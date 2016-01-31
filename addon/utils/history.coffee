`import moment from 'moment'`
`import _ from 'lodash/lodash'`
{merge} = _

class History
  identify = (model) ->
    mentionedType: model.constructor.modelName
    mentionedId: model.id

  @truckEntry = ({truck, gate}) ->
    core = 
      name: "truck-entrance"
      type: "pair"
      scheduledAt: moment()
      happenedAt: moment()
      message: "truck arrived at entrance"
    truck: merge core, identify(truck)
    gate: merge core, identify(gate)
  @truckScale = ({truck, scale}) ->
    core = 
      name: "truck-scale"
      type: "pair"
      scheduledAt: moment()
      happenedAt: moment()
      message: "truck arrived at weight station"
    truck: merge core, identify(truck)
    scale: merge core, identify(scale)
  @truckDock = ({truck, dock}) ->
    core = 
      name: "truck-dock"
      type: "pair"
      scheduledAt: moment()
      happenedAt: moment()
      message: "truck arrived at dock"
    truck: merge core, identify(truck)
    dock: merge core, identify(dock)
  @truckExit = ({truck, gate}) ->
    core = 
      name: "truck-exit"
      type: "single"
      scheduledAt: moment()
      happenedAt: moment()
      message: "truck has left the site"
    truck: merge core, identify(truck)
    gate: merge core, identify(gate)
`export default History`
