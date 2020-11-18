 $(document).on('ready turbolinks:load', function() {
     $('.custom-file-input').change(function(e) {
         var fileName = e.target.files[0].name;
         $(`.custom-file-label[for=${e.currentTarget['id']}]`).html(fileName);
     });
 });