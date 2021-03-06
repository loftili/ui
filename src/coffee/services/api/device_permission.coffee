DevicePermissionFactory = ['$resource', 'URLS', ($resource, URLS) ->

  default_params =
    id: '@id'

  DevicePermission = $resource [URLS.api, 'devicepermissions', ':id'].join('/'), default_params,
    query:
      method: 'GET'
      isArray: true
      interceptor:
        response: (response) ->
          return response

    search:
      method: 'GET'
      isArray: true

    delete:
      method: 'DELETE'
    
]

lft.service 'Api/DevicePermission', DevicePermissionFactory
