var isLike = false
var isBookmark = false

function likeFunction(e, podcast_album_id){
    isLike = $(`#is_like_${podcast_album_id}`).val()
    console.log(isLike)
    $.ajax({
        type: 'POST',
        contentType: false,
        cache: false,
        processData: false,
        url: 'http://127.0.0.1:3000/users/podcast_albums/' + podcast_album_id + '/like',
    })
        .done(() => {
            if (isLike == 'true'){
                console.log(isLike)
                $(`#is_like_${podcast_album_id}`).val('false')
                e.childNodes[0].classList.remove('fa-solid')
                e.childNodes[0].classList.add('fa-regular')
            }else{
                $(`#is_like_${podcast_album_id}`).val('true')
                e.childNodes[0].classList.remove('fa-regular')
                e.childNodes[0].classList.add('fa-solid')
            }
        })
        .fail((error) => {
            console.log(error);
        })
}

function bookmarkFunction(e, podcast_album_id){
    isBookmark = $(`#is_bookmark_${podcast_album_id}`).val()
    console.log(isBookmark)
    $.ajax({
        type: 'POST',
        contentType: false,
        cache: false,
        processData: false,
        url: 'http://127.0.0.1:3000/users/podcast_albums/' + podcast_album_id + '/toggle_bookmark',
    })
        .done(() => {
            if (isBookmark == 'true'){
                console.log(isBookmark)
                $(`#is_bookmark_${podcast_album_id}`).val('false')
                e.childNodes[0].classList.remove('fa-solid')
                e.childNodes[0].classList.add('fa-regular')
            }else{
                $(`#is_bookmark_${podcast_album_id}`).val('true')
                e.childNodes[0].classList.remove('fa-regular')
                e.childNodes[0].classList.add('fa-solid')
            }
        })
        .fail((error) => {
            console.log(error);
        })
}