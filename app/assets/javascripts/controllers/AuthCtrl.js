angular
  .module('myApp')
  .controller('AuthCtrl', function($scope, $http ,  $rootScope, Auth, $state ,$window){
    var config = {headers: {'X-HTTP-Method-Override': 'POST'}}

    $scope.register = function(){
      Auth.register($scope.user, config).then(function(user){
        $rootScope.user = user
        alert("Thanks for signing up, " + user.username);
        $window.localStorage.setItem("currentUser", angular.toJson($rootScope.user))

        $state.go('home');
      }, function(errorResponse){
      });
    };

		$scope.login = function(){
				Auth.login($scope.user, config).then(function(user){
					$http({
						method : "GET",
							url : "/GetLoggedUserInfo"
					}).then(function mySuccess(response) {
							console.log(response);
							$rootScope.user = response.data.data
							console.log($rootScope.user );
							$window.localStorage.setItem("currentUser", angular.toJson($rootScope.user))
							$state.go('home');
					}, function myError(response) {
						console.log(response);
					});
					$rootScope.user = user
					alert("Thanks for signing up, " + user.username);
				}, function(errorResponse){
				});
			}
  })
			//
			// 	$scope.login = function(){
			// 		Auth.login($scope.user, config).then(function(user){
			// 			// $http({
			// 			// 	method : "GET",
			// 			// 		url : "/GetLoggedUserInfo"
			// 			// }).then(function mySuccess(response) {
			// 			// 		console.log(response);
			// 			// 		$rootScope.user = response.data.data
			// 			// 		console.log($rootScope.user );
			// 			// 		$window.localStorage.setItem("currentUser", angular.toJson($rootScope.user))
			// 			// 		$state.go('home');
			// 			// }, function myError(response) {
			// 			// 	console.log(response);
			// 			// });
			// 			// $rootScope.user = user
			// 			// alert("Thanks for signing up, " + user.username);
			// 		}, function(errorResponse){
			// 		});
			// 	}
			//
			// })
