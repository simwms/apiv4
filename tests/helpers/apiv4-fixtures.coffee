store = (i) -> i.application.__container__.lookup("service:store")
loginAccount =  (i) ->
  i.session = (session = i.application.__container__.lookup("service:session"))
  i.userParams =
    email: "test@test.test"
    password: "password123"
  Cookies.remove "_apiv4_key"
  Cookies.remove "remember-token"

  i.session.login(i.userParams)
  .then =>
    i.session
    .get("model")
    .get("user")
    .then (user) =>
      i.user = user
      user.get("accounts")
    .then (accounts) =>
      i.account = (account = accounts.objectAt(0))
      session.update({account})

createCompany = (i) ->
  i.company = store(i).createRecord "company",
    name: "Test Co. #{Math.random()}"
  i.company.save()
  i.company

createAppointment = (i) ->
  company = i.company ? createCompany(i)
  i.appointment = store(i).createRecord "appointment",
    company: company
    externalReference: "scaffold-test-#{Math.random()}"
    description: "this is a test of the appointment creation system"
  i.appointment.save()
  i.appointment

createTruck = (i) ->
  appointment = i.appointment ? createAppointment(i)
  i.truck = store(i).createRecord "truck", {appointment}
  i.truck.save()
  i.truck

`export {loginAccount, createCompany, createAppointment, createTruck, store}`