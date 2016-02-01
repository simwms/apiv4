`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from '../../tests/helpers/start-app'`
`import History from 'apiv4/utils/history'`
{RSVP} = Ember
module 'Acceptance: HistoryPolymorph',
  beforeEach: ->
    @application = startApp()
    ###
    Don't return anything, because QUnit looks for a .then
    that is present on Ember.Application, but is deprecated.
    ###
    @store = @application.__container__.lookup("service:store")
    @session = @application.__container__.lookup("service:session")
    @userParams =
      email: "test@test.test"
      password: "password123"
    Cookies.remove "_apiv4_key"
    Cookies.remove "remember-token"
    return

  afterEach: ->
    Ember.run @application, 'destroy'

test "visit /", (assert) ->
  visit "/"

  andThen =>
    @session.login @userParams

  andThen =>
    @session
    .get("model")
    .get("user")
    .then (user) =>
      @user = user
      @user.get("accounts")
    .then (accounts) =>
      @account = accounts.objectAt(0)
  
  andThen =>
    @session.update(account: @account)

  andThen =>
    RSVP.hash
      dock: @store.findRecord "dock", 1
      truck: @store.findRecord "truck", 1
    .then ({dock, truck}) =>
      assert.ok dock, "we should have a dock"
      assert.ok dock.id, "we should have a dock id"
      @dock = dock
      assert.ok truck, "we should have a truck"
      assert.ok truck.id, "we should have a truck id"
      @truck = truck
  andThen =>
    {truck, dock} = History.truckEnterDock truck: @truck, dock: @dock
    @truckRel = @truck.relate("histories").associate truck
    @dockRel = @truck.relate("histories").associate dock
    assert.ok @truckRel
    assert.ok @dockRel
    
    RSVP.hash
      truck: @truckRel.save()
      dock: @dockRel.save()
    .catch (errors) =>
      console.log errors
      throw errors 

  andThen =>
    @truck
    .get "histories"
    .then (histories) =>
      assert.ok histories, "we should have histories"
      history = histories.get("firstObject")
      assert.ok history, "the history should not be empty"
      assert.ok history.id, "history should be ok"