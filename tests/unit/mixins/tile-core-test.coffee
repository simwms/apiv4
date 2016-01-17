`import Ember from 'ember'`
`import TileCoreMixin from '../../../mixins/tile-core'`
`import { module, test } from 'qunit'`

module 'Unit | Mixin | tile core'

# Replace this with your real tests.
test 'it works', (assert) ->
  TileCoreObject = Ember.Object.extend TileCoreMixin
  subject = TileCoreObject.create()
  assert.ok subject
