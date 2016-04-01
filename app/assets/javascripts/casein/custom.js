// CASEIN CUSTOM
// Use this file for your project-specific Casein JavaScript
//= require codemirror
//= require codemirror/modes/xml
//= require summernote

$(document).ready(function () {
    $.ajax('/casein/pages/titles.json', {
        dataType: 'json'
    }).then(function (data) {
        window.pagePaths = data;
    });
    
    function sendFile(file, callback) {
        var data = new FormData();
        data.append("image", file);
        $.ajax({
            url: '/casein/pages/image_upload.json',
            data: data,
            cache: false,
            contentType: false,
            processData: false,
            type: 'POST',
            dataType: 'json',
            success: function (response) {
                callback(response['image_url']);
            }
        });
    }
    
    $('.summernote').summernote({
        toolbar: [
            ['textstyle', ['bold', 'italic', 'underline', 'strikethrough']],
            ['parastyle', ['style', 'paragraph']],
            ['insert', ['ul', 'ol', 'link', 'picture', 'table', 'hr']],
            ['view', ['codeview']]
        ],
        disableDragAndDrop: true,
        callbacks: {
            onBlur: function () {
                var field = $(this);
                $('#' + field.data('backing-value')).val(field.summernote('code'));
            },
            onImageUpload: function (images, editor) {
                var i = 0,
                    field = $(this);
                
                for (i = 0; i < images.length; ++i) {
                    sendFile(images[i], function(imageUrl) {
                        field.summernote('insertImage', imageUrl);
                    });
                }
            }
        },
        hint: {
            match: /\[([A-Za-z0-9 ]+)$/,
            search: function (keyword, callback) {
                callback($.grep(pagePaths, function (page) {
                    return (
                        (page.title.toLowerCase().indexOf(keyword.toLowerCase()) >= 0) ||
                        (page.path.toLowerCase().indexOf(keyword.toLowerCase()) >= 0));
                }));
            },
            template: function (page) {
                return page.title;
            },
            content: function (page) {
                var link = $('<a />');
                link.attr('href', 'http://' + window.location.host + page.path);
                link.text(page.title);
                return link[0];
            }
        }
    });
});