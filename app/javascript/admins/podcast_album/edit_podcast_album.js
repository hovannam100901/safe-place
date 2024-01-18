const PodcastAlbumJs = {
  init: function () {
    this.handlePreview($("#img-input-edit"), $("#album_img-edit"));
  },

  readURL :function (input, image) {
  if (input.files && input.files[0]) {
    var reader = new FileReader();
    reader.onload = function(e) {
      image.attr('src', e.target.result);
    }
    reader.readAsDataURL(input.files[0]);
    }
  },

  handlePreview: function (input_tag, image){
    input_tag.change(function(e){
      PodcastAlbumJs.readURL(e.target, image);
    });
  }
}

PodcastAlbumJs.init()