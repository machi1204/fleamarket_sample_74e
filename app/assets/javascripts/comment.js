$(function(){ 
  function buildHTML(comment){
    if ( comment.item_user_id == comment.user_id ) {
      var html =
        `<ul class="comment-block clearfix">
          <li class="comment-user__nickname">
            出品者
          </li>
          <li class="comment-body">
            <div class="comment-body__text">
              ${comment.text}
              <br>
              <div class="comment-body__text--time">
                <i class="fa fa-clock"></i>
                ${comment.time}
              </div>
            </div>
          </li>
          <li class="comment-user__icon">
            <img src="/assets/member_photo_noimage_thumb-3f5db95de8bc1582908f994329d16ed91cf4398c2e3e0cc7387e0f2f8f0c88a9.png" width="40" height="40">
          </li>
        </ul>`
      return html;
    } else {
      var html =
        `<ul class="comment-block clearfix">
        <li class="comment-user__nickname">
          ${comment.user_name}
        </li>
        <li class="comment-body">
          <div class="comment-body__text">
            ${comment.text}
            <br>
            <div class="comment-body__text--time">
              <i class="fa fa-clock"></i>
              ${comment.time}
            </div>
          </div>
        </li>
        <li class="comment-user__icon">
          <img src="/assets/member_photo_noimage_thumb-3f5db95de8bc1582908f994329d16ed91cf4398c2e3e0cc7387e0f2f8f0c88a9.png" width="40" height="40">
        </li>
      </ul>`
      return html;
    };
  }

  $('#new-comment').on('submit', function(e){

    e.preventDefault();
    var formData = new FormData(this);
    var url = $(this).attr('action')
    $.ajax({
      url: url,
      type: "POST",
      data: formData,
      dataType: 'json',
      processData: false,
      contentType: false
    })
    .done(function(data){
      var html = buildHTML(data);
      $('.comment-container').append(html);
      $('.textbox').val('');
      $('.comment-btn').prop('disabled', false);
    })
    .fail(function(){
      alert('error');
    })
  })
})