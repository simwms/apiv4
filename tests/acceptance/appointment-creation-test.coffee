`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from '../../tests/helpers/start-app'`

module 'Acceptance: AppointmentCreation',
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

test 'visiting /appointment-creation', (assert) ->
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
    @store.findAll "company"
    .then (companies) =>
      @company = companies.objectAt(0)
    .then (company) =>
      @appointment = @store.createRecord "appointment",
        company: company
        externalReference: "testing-123"
        description: "this is a test of the appointment creation system"
      .save()
  andThen =>
    @appointment
    .get("histories")
    .then (histories) =>
      @history = histories.objectAt(0)

  andThen =>
    assert.ok @history
    assert.equal @history.get("name"), "appointment-created"