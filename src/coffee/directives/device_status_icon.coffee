_factory = () ->

  to_i = (num) -> parseInt num, 10

  lfDeviceStatusIcon =
    restrict: 'AE'
    replace: true
    templateUrl: 'directives.device_status_icon'
    scope:
      manager: '='
    link: ($scope, $element, $attrs) ->
      feed_loop_id = null
      $scope.time_diff = 1

      update = (err, ping_response) ->
        current_time = new Date().getTime()

        if err
          $scope.status = -1
          $scope.time_diff = -1
        else
          timestamp = ping_response.timestamp
          diff = current_time - timestamp
          $scope.time_diff = Math.round diff * 0.001
          $scope.status = to_i ping_response['player:state']

      $scope.$on '$destroy', () ->
        $scope.manager.feed.remove feed_loop_id

      feed_loop_id = $scope.manager.feed.add update

_factory.$inject = []

lft.directive 'lfDeviceStatusIcon', _factory