`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from '../../tests/helpers/start-app'`

module 'Acceptance: Channel',
  beforeEach: ->
    @application = startApp()
    ###
    Don't return anything, because QUnit looks for a .then
    that is present on Ember.Application, but is deprecated.
    ###
    @store = @application.__container__.lookup("service:store")
    @session = @application.__container__.lookup("service:session")
    @socket = @application.__container__.lookup("service:socket")
    @userChan = @application.__container__.lookup("service:user-chan")
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
    @loginFlag = false
    @session.on "login", =>
      @loginFlag = true
    @connectFlag = false
    @socket.on "connect", =>
      @connectFlag = true
    @session
    .login @userParams
    .then =>
      @socket.get("deferredSocket.promise")
  andThen =>
    assert.ok @loginFlag, "we should get the callback"
    assert.ok @connectFlag, "we should connect"

    @session.connect "user"
  andThen =>
    assert.ok @userChan.get("isConnected"), "user channel should be connected"