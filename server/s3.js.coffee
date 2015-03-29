Slingshot.createDirective "myFileUploads", Slingshot.S3Storage,
  bucket: "find-it"
  region: "us-west-2"
  acl: "public-read"

  authorize: ->
    true if Meteor.user()._id

  maxSize: 5 * 1024 * 1024 * 1024

  allowedFileTypes: ["audio/wav"]

  AWSAccessKeyId: "AKIAI2Z7JNLXOBBDYBAQ"
  AWSSecretAccessKey: "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"

  key: (file) ->
    Meteor.user()._id + new Date().toString()
