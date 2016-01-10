`import DS from 'ember-data'`
`import {RelateableMixin} from 'autox'`

Model = DS.Model.extend RelateableMixin,
  
  finishAt: DS.attr "moment"
  
  startAt: DS.attr "moment"
  

  

`export default Model`