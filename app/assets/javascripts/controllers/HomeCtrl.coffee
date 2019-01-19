angular
  .module('myApp')
  .controller 'HomeCtrl', ($scope,Auth,$location,$http,userService,$window) ->
    $scope.user = JSON.parse($window.localStorage.getItem("currentUser"))

    if $scope.user?
      $location.path '/login' if $scope.user isnt ""
      userService.getUserHolidays($scope.user.id).then (res) ->
        $scope.holidays = res
        if $scope.user.role is "user"
          userService.getUserHolidays($scope.user.id).then (res) ->
            $scope.holidays = res
        else
          userService.getAllHolidays().then (res) ->
            $scope.holidays = res
        # userService.getUserHolidays($scope.user.id).then (res) ->
        # $scope.holidays = res

      # else
        # userService.getAllHolidays().then (res) ->
        # $scope.holidays = res
      # userService.getUserHolidays($scope.user.id).then (res) ->
      #   $scope.holidays = res
      .catch (e) ->
        console.log 'access denied for user' ,e
    else
      $location.path '/login'

    $scope.sendDemande = ->
      date1 = moment($scope.dateStart)
      date2 = moment($scope.dateEnd)
      userService.sendDemande($scope.user.id,date1.format(),date2.format(),$scope.reason).then (res)->
        console.log(res)
        $scope.dateStart = ''
        $scope.dateEnd = ''
        $scope.reason = ''
        $scope.showMsgValid = true
        userService.getUserHolidays($scope.user.id).then (res) ->
          $scope.holidays = res
      .catch (e) ->
        console.log 'reject holiday for user' ,e
      ,(error) ->
        console.log 'error send request', error
        $scope.showMsgError = true

    $scope.getModel = (id) ->
      userService.getModel(id).then (res) ->
        console.log res
        $scope.myModel = res
      ,(error) ->
        console.log 'error get model',error

    $scope.acceptRequest = (id,user_id,db,df,solde) ->
            userService.sendAccept(id,user_id,db,df,solde).then (res) ->
              userService.getAllHolidays().then (res) ->
                $scope.users = res.data
              ,(error) ->
                console.log 'error users not found !' ,error
            ,(error) ->
                console.log error , 'Error reject demand'
                $scope.showMsgError = true
            ,(error) ->
              console.log error , 'Error reject demand'
              $scope.showMsgError = true
