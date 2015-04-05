Template.home.helpers
  currentSearch: ->
    Searches.findOne(Session.get('currentSearchId'))

  currentTags: ->
    placeTags.filter (tag) ->
      tag.active

Meteor.startup ->
  GoogleMaps.load { v: '3', key: 'AIzaSyBQxflXcLzTmlImPvUj8DAn6FmF4SgIQxg', libraries: 'places' }

Meteor.startup ->
  $('body').on "click", ".toggle", ->
    $(@).toggleClass('active')
