currentTags = ->
  placeTags.filter (tag) ->
    tag.active

Template.home.helpers
  currentSearch: ->
    Searches.findOne(Session.get('currentSearchId'))

  currentTags: ->
    currentTags()

  currentTagsCommaSeparated: ->
    tags = currentTags().map (tag) -> tag.name
    tags.join(', ')

  searchInProgress: ->
    searchInProgress

Meteor.startup ->
  GoogleMaps.load { v: '3', key: 'AIzaSyBQxflXcLzTmlImPvUj8DAn6FmF4SgIQxg', libraries: 'places' }

Meteor.startup ->
  $('body').on "click", ".toggle", ->
    $(@).toggleClass('active')
