`import DS from 'ember-data'`
`import {Mixins, Importance} from 'autox'`

{Relateable, Timestamps} = Mixins
Model = DS.Model.extend Timestamps, Relateable,
  name: DS.attr "string",
    label: "Company Name"
    description: "The name of the company"
    priority: Importance.Important
    display: ["show", "index"]
    modify: ["new", "edit"]
  address: DS.attr "string",
    label: "Address"
    description: "The street address of this company"
    priority: Importance.GoodToHave
    display: ["show"]
    modify: ["new", "edit"]
  address2: DS.attr "string",
    label: "Address Cont."
    description: "The room / building address of this company"
    priority: Importance.GoodToHave
    display: ["show"]
    modify: ["new", "edit"]
  city: DS.attr "string",
    label: "City"
    description: "The city or district of this company"
    priority: Importance.GoodToHave
    display: ["show"]
    modify: ["new", "edit"]
  state: DS.attr "string",
    label: "State"
    description: "The state or province of this company"
    priority: Importance.GoodToHave
    display: ["show"]
    modify: ["new", "edit"]
  zipcode: DS.attr "string",
    label: "Postal Code"
    description: "The zip or postal code of this company, for example: 90210"
    priority: Importance.GoodToHave
    display: ["show"]
    modify: ["new", "edit"]
  country: DS.attr "string",
    label: "Country"
    description: "The country name, for example: USA, P.R. China"
    priority: Importance.GoodToHave
    display: ["show"]
    modify: ["new", "edit"]
  latitude: DS.attr "number"
  longitude: DS.attr "number"
  appointments: DS.hasMany "appointment",
    label: "Appointments"
    description: "The appointments we have had with this company"
    display: ["show"]
    async: true
    link: true
  
`export default Model`