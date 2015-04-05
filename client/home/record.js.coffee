onError = (e) ->
  console.log(e)

recordIt = ($elem) ->
  session =
    audio: true
    video: false

  navigator.getUserMedia session, (mediaStream) ->
    @recordRTC = RecordRTC(mediaStream)
    @recordRTC.startRecording()
    $($elem).addClass("recoring").text("Stop Recording")
  , onError


dataURLToBlob = (dataURL) ->
  BASE64_MARKER = ';base64,'
  if dataURL.indexOf BASE64_MARKER  == -1
    parts = dataURL.split(',')
    contentType = parts[0].split(':')[1]
    raw = decodeURIComponent(parts[1])

    new Blob([raw], {type: contentType})

  parts = dataURL.split(BASE64_MARKER)
  contentType = parts[0].split(':')[1]
  raw = window.atob(parts[1])
  rawLength = raw.length

  uInt8Array = new Uint8Array(rawLength)

  for i in [0..rawLength]
    uInt8Array[i] = raw.charCodeAt(i)

  new Blob([uInt8Array], {type: contentType})

handleNewRecording = ->
  recordRTC.stopRecording (audioURL) ->
    recordedBlob = recordRTC.getBlob()
    recordRTC.getDataURL (dataURL) ->
      uploader = new Slingshot.Upload("myFileUploads")
      uploader.send dataURLToBlob(dataURL), (error, downloadUrl) ->
        console.log(error)
        searchId = Searches.insert
          user_id: Meteor.user()._id
          audio_url: downloadUrl
          categories: ["liquor_store"]
        beginSearch searchId


Meteor.startup ->
  recording = false
  $('body').on 'click', '#record-btn', (e) ->
    if recording
      recording = false
      $(@).hide().removeClass("recoring").text("Begin Recording")
      handleNewRecording()
    else
      recording = true
      recordIt(this)
    e.preventDefault()
