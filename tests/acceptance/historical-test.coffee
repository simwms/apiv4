`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from '../../tests/helpers/start-app'`
`import History from 'apiv4/utils/history'`
`import Fixtures from '../../tests/helpers/apiv4-fixtures'`

{loginAccount, createCompany, createAppointment, createTruck} = Fixtures
module 'Acceptance: Historical',
  beforeEach: ->
    @application = startApp()
    ###
    Don't return anything, because QUnit looks for a .then
    that is present on Ember.Application, but is deprecated.
    ###
    @store = @application.__container__.lookup("service:store")
    return

  afterEach: ->
    Ember.run @application, 'destroy'

test 'visiting /', (assert) ->
  visit '/'
  andThen => loginAccount(@)
  andThen => createCompany(@)
  andThen => createAppointment(@)
  andThen => createTruck(@)

  andThen =>
    assert.equal @truck.constructor.modelName, "truck"
    @truck
    .get("histories")
    .then (histories) =>
      history = histories.get "firstObject"
      assert.equal histories.get("length"), 1, "trucks should have 1 history"
      assert.equal history.get("name"), "truck-enter-site"
      assert.equal history.get("mentionedType"), "appointment", "the mentioned type should be correct"
      assert.equal history.get("mentionedId"), @appointment.id, "the mentioned id should match"

  andThen =>
    @appointment
    .get("histories")
    .then (histories) =>
      history = histories.get "lastObject"
      assert.equal histories.get("length"), 2, "appointments should have the right histories"
      assert.equal history.get("name"), "truck-enter-site"
      assert.equal history.get("mentionedType"), "truck", "mentioned type should be right"
      assert.equal history.get("mentionedId"), @truck.id, "mentioned id should match"

  andThen =>
    @store.findAll "dock"
    .then (docks) =>
      @dock = docks.get "firstObject"

  andThen =>
    History.createWith "truckEnterDock", {@dock, @truck}

  andThen =>
    @truck.get("histories").reload()
    .then (histories) =>
      assert.equal histories.get("length"), 2, "another history should be attached"
      history = histories.get("lastObject")
      assert.equal history.get("name"), "truck-enter-dock"
      assert.equal history.get("mentionedId"), @dock.id, "history should properly match relation"
      assert.equal history.get("mentionedType"), "dock"