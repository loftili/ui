dUserStreams = ($location, Lang, Api, Auth, Notifications) ->

  assert = (obj, prop, length) ->
    obj[prop] and obj[prop].length > length

  dUserStreamsLink = ($scope, $element, $attrs) ->
    $scope.new_stream = {}
    $scope.saving = false

    $scope.keyUp = (event) ->
      $scope.createStream() if event.keyCode == 13

    $scope.permissionFor = (stream) ->
      found = null

      for p in $scope.permissions
        if p.stream == stream.id
          found = p

      found

    makeStream = (stream) ->
      created_stream = null

      loadedPermissions = (permissions) ->
        for p in permissions
          $scope.permissions.push p

        $scope.streams.push created_stream

        $scope.new_stream =
          title: ''
          description: ''

      success = (s) ->
        created_stream = s
        (Api.StreamPermission.query
          stream: created_stream.id).$promise.then loadedPermissions, fail

      fail = () ->
        failed_lang = Lang 'streams.errors.create'
        Notifications.flash.error failed_lang

      (Api.Stream.save
        title: stream.title
        description: stream.description).$promise.then success, fail

    $scope.createStream = () ->
      new_stream = $scope.new_stream

      if (assert new_stream, 'title', 2) and (assert new_stream, 'title', 2)
        makeStream new_stream
      else
        Notifications.flash.info 'Please fill in all required fields'

  lfUserStreams =
    replace: true
    templateUrl: 'directives.user_streams'
    scope:
      streams: '='
      permissions: '='
    link: dUserStreamsLink

dUserStreams.$inject = [
  '$location'
  'Lang'
  'Api'
  'Auth'
  'Notifications'
]

lft.directive 'lfUserStreams', dUserStreams
