window.addEventListener("trix-file-accept", function(event) {
  const acceptedTypes = ['image/jpeg', 'image/png', 'image/gif']
  if (!acceptedTypes.includes(event.file.type)) {
    event.preventDefault()
    alert("Only support attachment of jpeg, png or gif files")
  }
})
