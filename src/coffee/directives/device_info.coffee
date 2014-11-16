lft.directive 'lfDeviceInfo', ['Api', (Api) ->

  lfDeviceInfo =
    replace: true
    templateUrl: 'directives.device_info'
    scope:
      device: '='
      permissions: '='
    link: ($scope, $element, $attrs) ->
      $scope.removePermission = (permission) ->
        finish = () ->
          for p, i in $scope.permissions
            if p.id == permission.id
              $scope.permissions.splice i, 1

        request = Api.DevicePermission.delete
          permission_id: permission.id

        request.$promise.then finish


]