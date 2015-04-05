Router.route '/', ->
  @render('home')

Router.route '/selectCategory', ->
  @render('selectCategory')

Router.route '/twilio/statusCallback',
  where: 'server'
  action: ->
    if @request.body.AnsweredBy != "human"
      searchObject = Searches.findOne(@params.query.searchId)
      placeObject = (i for i in searchObject.places when i.place_id is @params.query.placeId)[0]
      placeObject["status"] = "NO ANSWER"
      Searches.update
        '_id': @params.query.searchId
        'places.place_id': @params.query.placeId
        ,
          $set:
            'places.$': placeObject
    @response.end()

Router.route '/twilio/init_call',
  where: 'server'
  action: ->
    search = Searches.findOne(@params.query.searchId)
    transcribeCallbackUrl = "#{process.env.BASE_URL}/twilio/transcribe?searchId=#{search._id}&placeId=#{@params.query.placeId}".replace("&","&amp;")
    xmlData = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>";
    xmlData += "<Response>";
    # xmlData += "<Play>https://s3-us-west-2.amazonaws.com/find-it/Voice%2B012_Voice%2B012_generic.mp3</Play>";
    xmlData += "<Play>#{search.fixed_audio_url()}</Play>";
    xmlData += "<Record transcribe='true' playBeep='false' transcribeCallback='#{transcribeCallbackUrl}'/>"
    xmlData += "<Hangup/>"
    xmlData += "</Response>";
    @response.writeHead(200, {'Content-Type': 'application/xml'});
    @response.write(xmlData)
    @response.end()

Router.route '/twilio/transcribe',
  where: 'server'
  action: ->
    searchObject = Searches.findOne(@params.query.searchId)
    placeObject = (i for i in searchObject.places when i.place_id is @params.query.placeId)[0]
    placeObject["transcription"] = @request.body.TranscriptionText
    placeObject["status"] = "ANSWER"
    Searches.update
      '_id': @params.query.searchId
      'places.place_id': @params.query.placeId
      ,
        $set:
          'places.$': placeObject
    @response.end()
