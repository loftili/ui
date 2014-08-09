lft.config ['$routeProvider', ($routeProvider) ->

  $routeProvider.when '/dashboard',
    templateUrl: 'views.dashboard'
    controller: 'DashboardController'
    resolve:
      activeUser: ['Auth', (Auth) ->
        Auth.filter 'active'
      ]

]
