onError = (e) ->
  console.log(e)

recordIt = () ->
  session =
    audio: true
    video: false

  navigator.getUserMedia session, (mediaStream) ->
    @recordRTC = RecordRTC(mediaStream)
    @recordRTC.startRecording()
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


Meteor.startup ->
  $('body').on 'click', '.start', ->
    recordIt()

  $('body').on 'click', '.stop', ->
    recordRTC.stopRecording (audioURL) ->
      recordedBlob = recordRTC.getBlob()
      recordRTC.getDataURL (dataURL) ->
        uploader = new Slingshot.Upload("myFileUploads")
        uploader.send dataURLToBlob(dataURL), (error, downloadUrl) ->
          console.log(error)
          $('.audio-url').text(downloadUrl)
