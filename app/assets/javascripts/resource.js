var resourceApp = angular.module('resource-app', ['ngResource']).config(
	['$httpProvider', function($httpProvider){
	var authToken = angular.element("meta[name=\"csrf-token\"]").attr("content");
    var defaults = $httpProvider.defaults.headers;

    defaults.common["X-CSRF-TOKEN"] = authToken;
    defaults.patch = defaults.patch || {};
    defaults.patch['Content-Type'] = 'application/json';
    defaults.common['Accept'] = 'application/json';
}]);

resourceApp.factory('Resource', ['$resource', function($resource){
	return $resource('/resources/:id',
		{id: '@id'},
		{update: { method: 'PATCH'}});
}]);

resourceApp.controller('ResourceCtrl', ['$scope', 'Resource', function($scope, Resource){
	$scope.resources = [];

	$scope.newResource = new Resource();

	Resource.query(function(resources){
		$scope.resources = resources;
	});

	$scope.saveResource = function(){
		$scope.newResource.$save(function(resource){
			$scope.resources.push(resource)
			$scope.newResource = new Resource();
		});
	};

   $scope.searchWesource = function(resource) {
    return resource.title.indexOf($scope.search) >= 0 || resource.language.indexOf($scope.search) >= 0 || resource.link.indexOf($scope.search) >= 0;
	};

}]);