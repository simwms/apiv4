`import Ember from 'ember'`
`import moment from 'moment'`
`import _ from 'lodash/lodash'`
`import {createHistory, persistHistory} from 'autox/utils/create-history'`
`import {Mixins, action, _x} from 'autox'`
{computed, isBlank} = Ember
{computedTask} = _x.computed
class History
  @latestWasnt = (something) ->
    computed "model.histories.firstObject", ->
      @get("model").latestHistoryHas("name", something)
      .then (x) -> not x
  @latestWas = (something) ->
    computedTask "model.histories.firstObject", ->
      @get("model").latestHistoryHas("name", something)
  @newWith = (f, models) ->
    common = History[f]
    throw "Unknown history key #{f}, fix yo shit, son" if isBlank common
    createHistory common, models
  @createWith = (f, models) ->
    common = History[f]
    throw "Unknown history key #{f}, fix yo shit, son" if isBlank common
    persistHistory(common, models)
  @appointmentCreated =
    name: "appointment-created"
    message: "appointment created"
  @appointmentPickupBatch =
    name: "appointment-pickup-batch"
    message: "Load scheduled to be picked up by appointment"
  @appointmentDropoffBatch =
    name: "appointment-dropoff-batch"
    message: "Load dropped off at warehouse by appointment"
  @batchMoveCell =
    name: "batch-move-cell"
    message: "Load has moved to this storage cell"
  @truckEnterSite =
    name: "truck-enter-site"
    message: "truck arrived on site"
  @truckExitSite =
    name: "truck-exit-site"
    message: "truck has left the site"
  @truckEnterScale =
    name: "truck-enter-scale"
    message: "truck arrived at weight station"
  @truckExitScale =
    name: "truck-exit-scale"
    message: "truck has left weight station"
  @truckEnterDock =
    name: "truck-enter-dock"
    message: "truck arrived at dock"
  @truckExitDock =
    name: "truck-exit-dock"
    message: "truck has departed from the dock"
`export default History`
