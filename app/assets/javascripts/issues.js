(function() {
  $(function() {
    return $("#add_file").on("ajax:success", function(event, data) {
      $("#attachments").append(data);
      return $(this).data("params", {
        index: $("#attachments div.file").length
      });
    });
  });

}).call(this);