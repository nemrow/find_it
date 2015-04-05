Slingshot.createDirective "myFileUploads", Slingshot.S3Storage,
  bucket: "find-it"
  region: "us-west-2"
  acl: "public-read"

  authorize: ->
    true if Meteor.user()._id

  maxSize: 5 * 1024 * 1024 * 1024

  allowedFileTypes: ["audio/wav"]

  AWSAccessKeyId: process.env.AWS_ACCESS_KEY_ID
  AWSSecretAccessKey: process.env.AWS_SECRET_ACCESS_KEY

  key: (file) ->
    Meteor.user()._id + ".mp3"
