// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require rails-ujs
//= require_tree .
//= require vendor/icheck
//= require vendor/select2.min


$(document).ready(function() {

    $('#add_todo').click(function (event) {
        $('#todo_form').show();
    });
    $('#rem_todo').click(function (event) {
        $('#todo_form').hide();
    });

    let fuck_uglifier = $('#content input');
    let has_init = false;

    fuck_uglifier.iCheck({
        checkboxClass: 'icheckbox_square-blue',
        radioClass: 'iradio_square-blue',
    });

    fuck_uglifier.on('ifChecked', function(event){
        $(event.target).parent().next().css('text-decoration-line', 'line-through');
        if (has_init) {
            $(event.target).parent().parent().submit();
        }
    });

    fuck_uglifier.on('ifUnchecked', function (event) {
        $(event.target).parent().next().css('text-decoration-line', 'initial');
        if (has_init) {
            $(event.target).parent().parent().submit();
        }
    });

    $.each(to_mark, function (ind, v) {
       $("#todo" + v).iCheck('check');
    });
    has_init = true;

    $('#project_id').select2({
        minimumResultsForSearch: -1,
        placeholder: "Название задачи",
        allowClear: true
    });
    $('#open_create_form').click(function (event) {
        $('#create_form').show();
    });
    $('#close_crete_form').click(function (event) {
        $('#create_form').hide()
    });

});
