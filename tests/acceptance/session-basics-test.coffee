`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from '../../tests/helpers/start-app'`

module 'Acceptance: SessionBasics',
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

test 'visiting /', (assert) ->
  visit '/'

  andThen =>
    assert.equal currentURL(), '/'
    assert.equal @session.get("cookieKey"), "_apiv4_key"
    @session.login @userParams

  andThen =>
    session = @session.get("model")

    @rememberToken = session.get("rememberToken")
    assert.ok @rememberToken, "we should have a remember token"
    @oldCookie = Cookies.get "_apiv4_key"
    assert.ok @oldCookie
    assert.equal @oldCookie, @session.get("cookie")
    assert.equal Cookies.get("remember-token"), @rememberToken
    session
    .get("user")
    .then (user) =>
      @user = user

  andThen =>
    assert.ok @user, "the user should be there"
    assert.ok @user.get("id"), "the user should have id"
    @user
    .get("accounts")
    .then (accounts) =>
      @account = accounts.objectAt(0)

  andThen =>
    assert.ok @account, "user should have an account"
    assert.ok @account.get("id"), "account should have id"
    @session
    .get("model")
    .reload()
    @session.update(account: @account)

  andThen =>
    assert.equal Cookies.get("remember-token"), @rememberToken
    assert.equal @session.get("cookie"), Cookies.get("_apiv4_key"), "cookie match"
    assert.equal Cookies.get("_apiv4_key"), @oldCookie, "state is stored on the server, so the cookie stays the same"
  andThen =>
    @store.findAll "road"
    .then (roads) =>
      @roads = roads
      assert.ok roads
      assert.ok roads.get("length") > 1