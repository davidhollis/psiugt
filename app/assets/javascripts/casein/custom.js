// CASEIN CUSTOM
// Use this file for your project-specific Casein JavaScript
//= require summernote

$(document).ready(function () {
    $('.summernote').summernote({
        toolbar: [
            ['textstyle', ['bold', 'italic', 'underline', 'strikethrough']],
            ['parastyle', ['style', 'paragraph']],
            ['insert', ['ul', 'ol', 'link', 'picture', 'table', 'hr']]
        ],
        disableDragAndDrop: true,
        callbacks: {
            onBlur: function () {
                console.log(this);
                var field = $(this);
                $('#' + field.data('backing-value')).val(field.summernote('code'));
            }
        }
    });
});