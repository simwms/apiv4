`import DS from 'ember-data'`
`import {Mixins} from 'autox'`
{Timestamps, Relateable, Paranoia} = Mixins
Model = DS.Model.extend Timestamps, Relateable, Paranoia,
  name: DS.attr "string",
    label: "Service Plan Name"
    description: "The human readable name of this service / subscription plan"
    display: ["show", "index"]
    modify: ["new", "edit"]
  
  amount: DS.attr "number",
    label: "Monthly Subscription Cost"
    description: "The pro-rated amount of money this plan costs in US cents"
    modify: ["new", "edit"]
  
  cells: DS.attr "number",
    label: "Storage Cell Avability"
    description: "The number of storage cells available in this service plan"
    display: ["show"]
    modify: ["new", "edit"]

  currency: DS.attr "string",
    label: "Currency Code"
    description: "The standard currency code of price"
  
  description: DS.attr "string",
    display: ["show"]
    modify: ["new", "edit"]  
  
  docks: DS.attr "number",
    label: "Loading Dock Avability"
    description: "The number of truck loading docks available in this service plan"
    display: ["show"]
    modify: ["new", "edit"]
  
  employees: DS.attr "number",
    label: "Team Size"
    description: "The number of user accounts available in this service plan"
    display: ["show"]
    modify: ["new", "edit"]

  interval: DS.attr "string",
    description: "Amount of time between subscription payments"
    among: ["daily", "weekly", "monthly", "bimonthly", "yearly"]
  
  intervalCount: DS.attr "number",
    description: "I don't remember what this is"
  
  presentation: DS.attr "string",
    description: "I'm not sure what this is, probably a name field except better formed"
  
  scales: DS.attr "number",
    label: "Weight Station Avability"
    description: "The number of weight station scales available in this service plan"
    display: ["show"]
    modify: ["new", "edit"]

  storage: DS.attr "number",
    label: "Data Storage"
    description: "The amount of data (in megabytes) stored on our cloud servers"
    display: ["show"]
    modify: ["new", "edit"]

  dataflow: DS.attr "number",
    label: "Data Transfer"
    description: "The maximum amount of data (in megabytes) uploaded and downloaded allowed per month"
    display: ["show"]
    modify: ["new", "edit"]

  dailyUptime: DS.attr "number",
    label: "Daily Operation Hours"
    description: "The number of hours per day the cloud warehouse server is open to access"
    display: ["show"]
    modify: ["new", "edit"]

  customDomain: DS.attr "boolean",
    label: "Customizeable Domain Name"
    description: "Whether or not this warehouse management software can be delivered via your company's domain name"
    display: ["show"]
    modify: ["new", "edit"]

  dataBackup: DS.attr "number",
    label: "Private Data Backup Eligiblity"
    description: "Whether or not your warehouse application data can be privately backed up"
    display: ["show"]
    modify: ["new", "edit"]

  stripePlanId: DS.attr "string",
    label: "Stripe Plan Id"
    description: "The name of this subscription plan as it appears on Stripe"

`export default Model`