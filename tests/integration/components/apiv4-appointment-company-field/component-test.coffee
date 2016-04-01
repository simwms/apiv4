`import { test, moduleForComponent } from 'ember-qunit'`
`import hbs from 'htmlbars-inline-precompile'`

moduleForComponent 'apiv4-appointment-company-field', 'Integration | Component | apiv4 appointment company field', {
  integration: true
}

test 'it renders', (assert) ->
  assert.expect 2

  # Set any properties with @set 'myProperty', 'value'
  # Handle any actions with @on 'myAction', (val) ->

  @render hbs """{{apiv4-appointment-company-field}}"""

  assert.equal @$().text().trim(), ''

  # Template block usage:
  @render hbs """
    {{#apiv4-appointment-company-field}}
      template block text
    {{/apiv4-appointment-company-field}}
  """

  assert.equal @$().text().trim(), 'template block text'
