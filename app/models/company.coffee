`import DS from 'ember-data'`
`import {RelateableMixin} from 'autox'`

`import Timestamps from 'autox/mixins/timestamps'`
Model = DS.Model.extend Timestamps, RelateableMixin,
  name: DS.attr "string",
    label: "Company Name"
    description: "The name of the company"
    display: ["show", "index"]
    modify: ["new", "edit"]
  address: DS.attr "string",
    label: "Address"
    description: "The street address of this company"
    display: ["show"]
    modify: ["new", "edit"]
  address2: DS.attr "string",
    label: "Address Cont."
    description: "The room / building address of this company"
    display: ["show"]
    modify: ["new", "edit"]
  city: DS.attr "string",
    label: "City"
    description: "The city or district of this company"
    display: ["show"]
    modify: ["new", "edit"]
  state: DS.attr "string",
    label: "State"
    description: "The state or province of this company"
    display: ["show"]
    modify: ["new", "edit"]
  zipcode: DS.attr "string",
    label: "Postal Code"
    description: "The zip or postal code of this company, for example: 90210"
    display: ["show"]
    modify: ["new", "edit"]
  country: DS.attr "string",
    label: "Country"
    description: "The country name, for example: USA, P.R. China"
    display: ["show"]
    modify: ["new", "edit"]
  latitude: DS.attr "number"
  longitude: DS.attr "number"
  appointments: DS.hasMany "appointment", async: true
  
`export default Model`