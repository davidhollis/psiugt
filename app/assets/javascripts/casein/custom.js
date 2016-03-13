// CASEIN CUSTOM
// Use this file for your project-specific Casein JavaScript
//= require codemirror
//= require codemirror/modes/xml
//= require summernote

$(document).ready(function () {
    $.ajax('/casein/pages.json', {
        dataType: 'json'
    }).then(function (data) {
        window.pagePaths = data;
    });
    
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