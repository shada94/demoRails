angular
  .module('myApp')
  .service 'userService', ($http,$q, $window)->

    this.getUserHolidays = (id) ->
        deffered = $q.defer()
        $http.get('/holiday/getUserHolidays/'+id).then (holidays) ->
          res = holidays.data.data
          deffered.resolve(res)
        ,(error)->
          console.log error,'Holidays User not found'
          deffered.reject(error)
        return deffered.promise

    this.sendDemande = (id,d1,d2,reason) ->
      deffered = $q.defer()
      Indata = {'user_id':id,'dateStart':d2,'dateEnd':d1, 'reason':reason}
      console.log Indata
      headers = {'Content-Type': 'application/json'}
      $http.post('/holiday/saveHoliday',Indata,headers).then (response) ->
          res = response.data.data
          deffered.resolve(res)
      ,(error) ->
        console.log error, 'can not save demand !.'
        deffered.reject(error)
      return deffered.promise

    this.getModel = (id) ->
      deffered = $q.defer()
      $http.get('/holiday/getUserHolidayModel/'+id).then (model) ->
        res = model.data.data
        deffered.resolve(res)
      ,(error)->
        console.log error,'model User not found'
        deffered.reject(error)
      return deffered.promise

    this.sendAccept = (id,user_id,db,df,solde) ->
      deffered = $q.defer()
      _MS_PER_DAY = 1000 * 60 * 60 * 24
      a = moment(db)
      b = moment(df)
      utc1 = Date.UTC(a.year(), a.month(), a.date())
      utc2 = Date.UTC(b.year(), b.month(), b.date())
      res = Math.floor((utc2 - utc1) / _MS_PER_DAY)
      resF = solde-res
      Indata = {id : id, state :'accepted',user_id : user_id, balance : resF}
      headers = {'Content-Type': 'application/json'}
      $http.post('/holiday/AcceptHoliday/',Indata,headers).then (response) ->
          angular.element('#exampleModal').modal('hide')
          res = response.data
          deffered.resolve(res)
      ,(error) ->
          console.log error , 'Error reject demand'
          deffered.reject(error)
       return deffered.promise
    this.getAllHolidays = ->
        deffered = $q.defer()
        $http.get('/holiday/getAllHolidays/').then (holidays) ->
          res = holidays.data.data
          deffered.resolve(res)
        ,(error)->
          console.log error,'Holidays  not found'
          deffered.reject(error)
        return deffered.promise
    return this
