`import Ember from 'ember'`
`import LineCoreMixin from '../../../mixins/line-core'`
`import { module, test } from 'qunit'`

module 'Unit | Mixin | line core'

# Replace this with your real tests.
test 'it works', (assert) ->
  LineCoreObject = Ember.Object.extend LineCoreMixin
  subject = LineCoreObject.create()
  assert.ok subject
