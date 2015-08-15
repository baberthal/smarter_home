# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
#

jQuery ->

  console.log devices

  $('#nest-interface #left-side .list-group a').each ->
    $(@).on 'click', (e)->
      e.preventDefault()
      updateDeviceView($(@).attr('id'))
      $(@).addClass('active')
      $(@).siblings().removeClass('active')

  updateDeviceView = (deviceId) ->
    $('#viewing-area').replaceWith(deviceView(findDevice(deviceId)))

  findDevice = (deviceId, objArr) ->
    objArr ||= window.devices
    result = $.grep(objArr, (e) ->
      return e.id == deviceId
    )
    result[0]

  deviceView = (device) ->
    viewingArea(
      """
      <h1 class='device-info' id='#{device['id']}'>
        #{device['name']}
      </h1>
      """
    )

  viewingArea = (contentToYield) ->
    "<div class='well' id='viewing-area'>#{contentToYield}</div>"



#  vim: set ts=8 sw=2 tw=78 ft=coffee et :
