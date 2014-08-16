lft.directive 'lfEditFieldInput', ['$rootScope', ($rootScope) ->
  
  lfEditFieldInput =
    scope: false
    require: ['^lfEditField', 'ngModel']
    link: ($scope, $element, $attrs, controllers) ->
      editField = controllers[0]
      model = controllers[1]
      original_value = null

      keyman = (evt) ->
        is_save = evt.keyCode == 13
        if is_save or evt.keyCode == 27
          editField.close is_save, model.$modelValue
          $rootScope.$digest()

      focus = () ->
        $element[0].focus()
        original_value = model.$modelValue

      blurOut = () ->
        editField.close false, original_value
        $rootScope.$digest()

      editField.add focus

      $element.on 'keyup', keyman
      $element.on 'blur', blurOut
      $scope.$on 'openedEditField', focus

]
