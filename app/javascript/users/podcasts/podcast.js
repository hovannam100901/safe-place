document.getElementById('img-input').addEventListener('change', function(event) {
    const file = event.target.files[0];
    const albumImg = document.getElementById('album_img');
    const reader = new FileReader();

    reader.onload = function(e) {
    albumImg.src = e.target.result;
    };

    if (file) {
    reader.readAsDataURL(file);
    }
});
