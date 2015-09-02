var sensor=angular.module('sensor', []);
sensor.run(function($rootScope,$http,$interval) {
	var self= $rootScope;
	self.getDevices = function(){
		$http.get("/devices.php").success(function(response,status,headers,config){
			self.devices = response;
			self.requestNew();
		}).error(function(data, status, headers, config) {
			console.log(status);
		});
	}
	self.requestNew = function(device){
		self.currentDevice = device;
		self.getData();
	}
	self.getData = function(){
		var requestUrl="/data.php?";
		if (self.currentDevice != undefined){
			var params ={device:self.currentDevice.id};
			requestUrl = requestUrl +$.param(params);
		}
		$http.get(requestUrl).success(function(response,status,headers,config){
			self.data = response;
		}).error(function(data, status, headers, config) {
			console.log(status);
		});
	}
	$interval(self.getData,2000);
});

