var isHandlingChange = false;
$(document).on("change", ".anonymous-switch", function () {
  if (isHandlingChange) {
    return;
  }

  isHandlingChange = true;

  var userId = $(this).attr("id").replace("user_anonymous_", "");
  var isChecked = $(this).prop("checked");
  var url = "/admins/users/" + userId + "/toggle_anonymous";

  $.ajax({
    type: "PATCH",
    url: url,
    data: {
      anonymous: isChecked,
      authenticity_token: $("meta[name='csrf-token']").attr("content"),
    },
    success: function (data) {
      console.log('The "Anonymous" status has been updated successfully.');
      isHandlingChange = false;
    },
    error: function () {
      console.log('An error occurred while updating the "Anonymous" status.');
      isHandlingChange = false;
    },
  });
});
