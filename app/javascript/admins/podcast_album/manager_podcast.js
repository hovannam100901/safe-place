let podcast_id = 0
let podcast_album_id = 0
let podcast_url = "/admins/podcasts"
let imageFile
let audioFile

function updatePodcast(podcastId){
    console.log(podcast_url)
    console.log(podcastId)
    $.ajax({
        type: 'GET',
        url: podcast_url + '/' + podcastId
    })
        .done((data) => {
            let name = $(`#input_name_podcast_${podcastId}`).val();
            console.log(name)
            let obj = {
                name: name
            }
            console.log(obj)
            $.ajax({
                type: 'PATCH',
                url: `${podcast_url}/${podcastId}`,
                dataType: 'json',
                data: obj
            })
                .done((podcast) => {
                    alert("Update successfully")
                    $(`#input_name_podcast_${podcastId}`).val(podcast.name)
                })
                .fail((error) => {
                    console.log(error);
                })
        })
        .fail((error_data) => {
            console.log(error_data.errors);
        })
}

function deletePodcast(podcastId){
    $.ajax({
        type: 'GET',
        url: podcast_url + '/' + podcastId
    })
        .done((data) => {
            let id = data.id
            let confirmed = confirm("Are you sure to delete this podcast?")
            if(confirmed){
                $.ajax({
                    headers: {
                        'accept': 'application/json',
                        'content-type': 'application/json'
                    },
                    type: 'DELETE',
                    url: podcast_url + '/' + id,
                })
                    .done(() => {

                        $('#podcast-' + id).remove();

                    })
                    .fail((error) => {
                        console.log(error)
                    })
            }
        })
        .fail((error) => {
            console.log(error);
        })
}

function cancelEdit(podcastId){
    $.ajax({
        type: 'GET',
        url: podcast_url + '/' + podcastId
    })
        .done((data) => {
            $(`#input_name_podcast_${podcastId}`).val(data.name);
        })
        .fail((errors) => {
            console.log(errors);
        })
}

function openModalCreatePodcast(album_id){
    $('#modalCreatePodcast').modal('show');
    $('#modalShowAlbum').removeClass('modal')
    podcast_album_id = album_id
}

function createPodcast(){
    let album_id = podcast_album_id;
    let name = $("#crePodcastName").val();
    let author_name = $("#creAuthorName").val();
    let episode_number = $("#creEpNumber").val();

    let formData = new FormData();
    formData.append("name", name);
    formData.append("author_name", author_name);
    formData.append("episode_number", episode_number);
    formData.append("image", imageFile);
    formData.append("audio", audioFile);
    formData.append("podcast_album_id", album_id)

    $.ajax({
        type: 'POST',
        url: podcast_url,
        contentType: false,
        cache: false,
        processData: false,
        data: formData
    })
        .done((data) => {
            let str = renderPodcast(data)
            alert("Create successful")
            $('#modalCreatePodcast').modal('hide');
            $('#modalShowAlbum').addClass('modal');
            let count = $("#all_podcast tr").length;
            console.log(count)
            if (count === 0){
                $("#all_podcast").empty();
                let table_head = renderTableHead();
                $("#all_podcast").append(table_head);
            }

            $("#podcast_table").append(str);
            $("#createPodcastForm")[0].reset();
        })
        .fail((error) => {
            $('.alert_create_podcast').empty();
            $('.alert_create_podcast').attr("style", "display:block")
            $.each(error.responseJSON, (i, item) => {
                $('.alert_create_podcast').append(`<li>${item}</li>`)
            })
        })
}

function renderPodcast(podcast){
    return `<tr id="podcast-${podcast.id}">
        <td>${podcast.id}</td>
        ${podcast.image.url != null ? `<td><img src="${podcast.image.url}" alt="Podcast Avatar" class="" style="width: 80px; height: 80px; border-radius: 50%"></td>` : `<td><img src="../assets/podcast.jpg" alt="Album Avatar" class="" style="height: 80px; border-radius: 50%"></td>`}
        <td id="podcast_name_${podcast.id}" data-id="${podcast.id}"><input class="form-control" type='text' value='${podcast.name}' id='input_name_podcast_${podcast.id}'></td>
        <td class="text-end"><button class="btn btn-warning button_cancel" data-id="${podcast.id}" onclick="cancelEdit(${podcast.id})"><i class="fa-solid fa-arrow-rotate-left"></i></button></td>
        <td class="text-center"><button class="btn btn-danger delete_podcast" data-id="${podcast.id}" onclick="deletePodcast(${podcast.id})"><i class="fa-solid fa-trash"></i></button></td>
        <td class="text-start"><button class="btn btn-primary bg_green border_green button_done" data-id="${podcast.id}" onclick="updatePodcast(${podcast.id})"><i class="fa-solid fa-check"></i></button></td>
      </tr>`
}

function renderTableHead(){
    return `<thead>
                <tr class="table-light">
                  <th scope="col">ID</th>
                  <th scope="col">Avatar</th>
                  <th scope="col">Podcast Name</th>
                  <th scope="col" colspan="3">Action</th>
                </tr>
            </thead>
            <tbody id="podcast_table"></tbody>`
}

$('#modalCreatePodcast').on('hidden.bs.modal', () => {
    $("#createPodcastForm")[0].reset();
    $('.alert_create_podcast').attr("style", "display:none");
    $('.alert_create_podcast').empty();
    $('#modalShowAlbum').addClass('modal');
})


$('#crePodcastImage').change(function(e){
    var imageName = e.target.files[0].name;
    imageFile = e.target.files[0];
});
$('#crePodcastAudio').change(function(e){
    var audioName = e.target.files[0].name;
    audioFile = e.target.files[0];
});