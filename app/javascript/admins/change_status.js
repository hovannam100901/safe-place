var isHandlingChange = false;

$(document).on("change", ".anonymous-switch-room", function () {
  // if (isHandlingChange) {
  //   return;
  // }
  // isHandlingChange = true;
  var roomId = $(this).attr("id").replace("room_anonymous_", "");
  var isChecked = $(this).prop("checked");
  var url = "/admins/rooms/" + roomId + "/change_status";

  $.ajax({
    type: "PATCH",
    url: url,
    data: {
      status: isChecked ? "enable" : "disable", 
      authenticity_token: $("meta[name='csrf-token']").attr("content"),
    },
    success: function (data) {
      console.log('The "Anonymous" status has been updated successfully.');
    },
    error: function () {
      console.log('An error occurred while updating the "Anonymous" status.');
    }
  });
});