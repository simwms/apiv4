`import moment from 'moment'`
`import _ from 'lodash/lodash'`
{merge} = _

class History
  identify = (model) ->
    mentionedType: model.constructor.modelName
    mentionedId: model.id

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
`export default History`
