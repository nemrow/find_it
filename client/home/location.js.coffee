placesCount = null
searchData = {}
currentRadius = 200
currentSearch = null
latLongOverride = {}

runFinder = ->
  searchData.places = []
  placesCount = null

  overridingData = {}
  for input in latLongOverride
    overridingData[input.name] = input.value unless input.value.length == 0

  if @currentCoordinates
    $.extend searchData, {latitude: @currentCoordinates.lat(), longitude: @currentCoordinates.lng()}

  $.extend searchData, overridingData

  sendNearbyRequest()

sendNearbyRequest = ->
  @latLng = new google.maps.LatLng(searchData.latitude, searchData.longitude)
  @map = new google.maps.Map($('#map-node')[0], {center: @latLng, zoom: 15})

  tags = placeTags.filter (tag) -> tag.active
  tagsArray = tags.map (tag) -> tag.tag

  # alert('no tags') if tagsArray.length < 1

  nearbyRequestData = {
    location: @latLng
    radius: currentRadius
    open_now: true
    types: tags.map (tag) -> tag.tag
  }

  @placesService = new google.maps.places.PlacesService(@map)

  @placesService.nearbySearch(nearbyRequestData, nearbyCallback)

nearbyCallback = (results, status) ->
  placesCount = results.length
  if currentRadius > 4828 && placesCount < 5
    $('.places-data').text "not enough spots around you"
  else if placesCount < 12
  # else if placesCount < 3
    $('.places-data').text "#{placesCount} found so far"
    setTimeout ->
      currentRadius += 200
      sendNearbyRequest()
    , 330
  else
    $('.places-data').text "Found #{placesCount} places."
    nearbyBatcher(results, 0)

nearbyBatcher = (results, currentIndex) ->
  nextIndex = currentIndex + 5
  currentBatch = results.slice(currentIndex, nextIndex)
  for place in currentBatch
    @placesService.getDetails({placeId: place.place_id}, detailCallback)
  setTimeout ->
    nearbyBatcher(results, nextIndex) if results[nextIndex] != undefined
  , 2000

detailCallback = (place, status) ->
  searchData.places.push neededPlaceAttrs(place) if status == "OK"
  placesSearchComplete() if --placesCount == 0

neededPlaceAttrs = (place) ->
  name: place.name
  address: place.address_components
  types: place.types
  phone_number: place.formatted_phone_number
  place_id: place.place_id
  vicinity: place.vicinity
  photo: ((place.photos[0].getUrl({'maxWidth': 100, 'maxHeight': 100}) if place.photos) || place.icon)

placesSearchComplete = () ->
  placesNames = searchData.places.map (place) ->
    place.name

  miles = (currentRadius / 1600).toFixed(1)

  $('.places-data').text "We found #{placesNames.length} places within #{miles} miles of you that we are checking"

  Searches.update(currentSearch._id, {$set: {places: searchData.places}})
  Session.set("currentSearchId", currentSearch._id)

  Meteor.call 'initPhoneCalls', (currentSearch._id), (error, result) ->
    console.log error
    console.log result

@beginSearch = (searchId) ->
  currentSearch = Searches.findOne(searchId)
  $('.places-data').text "Finding your location"
  navigator.geolocation.getCurrentPosition(initializeLocation, locationError, mapOptions)

initializeLocation = (pos) ->
  if $('input[name=lat]').val().length > 0 && $('input[name=lon]').val().length > 0
    searchData['latitude'] = $('input[name=lat]').val()
    searchData['longitude'] = $('input[name=lon]').val()
  else
    @currentCoordinates = new google.maps.LatLng pos.coords.latitude, pos.coords.longitude
  runFinder()

locationError = (err) ->
  console.warn('ERROR(' + err.code + '): ' + err.message)

mapOptions = {
  enableHighAccuracy: true
  timeout: 75000
  maximumAge: 3000
}
