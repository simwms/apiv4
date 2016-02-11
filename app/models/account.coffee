`import DS from 'ember-data'`
`import {RelateableMixin} from 'autox'`
`import Timestamps from 'autox/mixins/timestamps'`
`import Paranoia from 'autox/mixins/paranoia'`
Model = DS.Model.extend Timestamps, RelateableMixin, Paranoia,
  name: DS.attr "string",
    label: "Name"
    description: "The good and rememberable user-defined name that defines this object"
    display: ["show", "index"]
    modify: ["edit", "new"]
  
  stripeSource: DS.attr "string",
    label: "Stripe Source"
    description: "A string of encrypted characters that represent customer credit card data via Stripe"
    modify: ["edit"]

  stripeSubscriptionId: DS.attr "string",
    label: "Stripe Subscription Id"
    description: "The id of the subscription object stored on Stripe's remote servers"
  
  timezone: DS.attr "string",
    label: "Warehouse Timezone"
    description: "The timezone where this warehouse is located"
    modify: ["new", "edit"]
    display: ["show"]

`export default Model`