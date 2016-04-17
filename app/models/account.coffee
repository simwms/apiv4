`import DS from 'ember-data'`
`import {Mixins, Importance} from 'autox'`

{Relateable, Timestamps, Paranoia} = Mixins
Model = DS.Model.extend Timestamps, Relateable, Paranoia,
  name: DS.attr "string",
    label: "Name"
    description: "The good and rememberable user-defined name that defines this object"
    priority: Importance.VeryImportant
    display: ["show", "index"]
    modify: ["edit", "new"]
  
  stripeSource: DS.attr "string",
    label: "Stripe Source"
    description: "A string of encrypted characters that represent customer credit card data via Stripe"

  stripeSubscriptionId: DS.attr "string",
    label: "Stripe Subscription Id"
    description: "The id of the subscription object stored on Stripe's remote servers"
  
  timezone: DS.attr "string",
    label: "Warehouse Timezone"
    description: "The timezone where this warehouse is located"
    priority: Importance.Important
    modify: ["new", "edit"]
    display: ["show"]

  servicePlan: DS.belongsTo "service-plan",
    label: "Warehouse Service Plan"
    description: "The subscription plan which describes what services are available in this warehouse account"
    priority: Importance.Important
    display: ["show"]
    modify: ["model#upgrade"]
    among: -> @store.findAll "service-plan"
    proxyKey: "name"
    async: true
    link: true

`export default Model`