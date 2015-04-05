twilio = Twilio(process.env.TWILIO_SID, process.env.TWILIO_AUTH_TOKEN)

placeCall = (recipient, params) ->
  twilio.makeCall
      to: recipient
      from: '+14157636769'
      if_machine: "Hangup"
      ifMachine: "Hangup"
      status_callback: "#{process.env.BASE_URL}/twilio/statusCallback?#{params}"
      statusCallback: "#{process.env.BASE_URL}/twilio/statusCallback?#{params}"
      url: "#{process.env.BASE_URL}/twilio/init_call?#{params}"
  , (err, responseData) ->
    console.log responseData.from

Meteor.startup ->
  Meteor.methods
    sendTextMessage: (recipient, body) ->
      twilio.sendSms
        to: recipient
        from: '+14157636769'
        body: body
      , (err, responseData) ->
        if !err
          console.log(responseData.from)
          console.log(responseData.body)

    initPhoneCalls: (searchId) ->
      for place in Searches.findOne(searchId).places
        # placeCall "17078496085", "searchId=#{searchId}&placeId=#{place.place_id}"
        placeCall place.phone_number, "searchId=#{searchId}&placeId=#{place.place_id}"
