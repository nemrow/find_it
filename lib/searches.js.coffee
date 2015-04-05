@Searches = new Mongo.Collection("searches")

@Searches.helpers
  isComplete: ->
    console.log @status
    @status?

  fixed_audio_url: ->
    if @audio_url.match(/https:\/\w/)
      @audio_url.replace(/https:\//, "https://")
    else
      @audio_url
