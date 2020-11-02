window.addEventListener("trix-file-accept", function(event) {
    const acceptedTypes = ['image/jpeg', 'image/png', 'video/mp4', 'image/jpg']
    if (!acceptedTypes.includes(event.file.type)) {
        event.preventDefault()
        alert("Only supports jpeg, png or mp4 files")
    }
})

window.addEventListener("trix-file-accept", function(event) {
    if (event.file.size > 4096000000) {
        event.preventDefault()
        alert("Only supports attachments upto size 512mb")
    }
})