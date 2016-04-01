`import Ember from 'ember'`
`import layout from './template'`

Apiv4AppointmentCompanyFieldComponent = Ember.Component.extend
  layout: layout
  store: Ember.inject.service()

  createNewCompany: ->
    name = @get "currentSearchTerm"
    store = @get "store"
    model = @get "model"
    @set "isBusy", true
    store.createRecord "company", {name}
    .save()
    .then (company) ->
      model.set "comany", company
    .finally =>
      @set "isBusy", false


Apiv4AppointmentCompanyFieldComponent.reopenClass
  positionalParams: ['formHeart']

`export default Apiv4AppointmentCompanyFieldComponent`
