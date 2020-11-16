$(document).on('ready turbolinks:load', function() {
    $('.custom-file-input').change(function() {
        $('.custom-file-label').text(this.value);
    });
});