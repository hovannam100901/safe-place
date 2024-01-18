
document.addEventListener('DOMContentLoaded', function() {
    // Lắng nghe sự kiện khi nút Join được nhấp vào
    const joinButtons = document.querySelectorAll('.join_room_button');
    joinButtons.forEach(button => {
      button.addEventListener('click', function() {
        const roomId = this.getAttribute('data-room-id');
        // console.log(roomId);
        joinRoomAjax(roomId);
      });
})
   
})


function joinRoomAjax(roomId) {
    const csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute('content');

    $.ajax(`/users/rooms/${roomId}/join_room`, {
      method: 'PATCH',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': csrfToken,
      },
    })
    .then(data => {
      console.log(data) 
      if (data.status == 200) {
        alert('Join room successfully.');
        window.location.href = `/users/rooms/${roomId}/room_chat`
      } else {
        alert('Failed to join room.');
      }
    })
}




