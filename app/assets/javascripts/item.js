$(function(){
  var index = [0,1,2,3,4,5,6,7,8,9];
  $(".flexbox").on("click", ".delete", function(){
    $(document).on('page:load', 'ready')
    var targetIndex = Number($(this).attr("index"));
    index.push(targetIndex);
    if($(this).parent().parent().attr("class") == "new-contents__box__preview-first"){
      $(".new-contents__box__preview .new-contents__box__preview__image:first").appendTo(".new-contents__box__preview-first");
    }
    if(index.length > 6){
      $(".new-contents__box__image-area").css("width",(index.length-5)*130);
    }else if(index.length == 6){
      $("#image-field-second").remove();
      $(".new-contents__box__preview").remove();
      $(".new-contents__box__preview-first").attr("class", "new-contents__box__preview");
      $(".new-contents__box__image-area").css("display","flex");
    }else if(index.length == 1){
      $("#image-field-second").css("display","flex");
      $("#image-field-second").css("width",index.length*130);
    }else{
      $("#image-field-second").css("width",index.length*130);
    }
    $("#image-label").attr("for",`item_images_attributes_${targetIndex}_image`);
    $(this).parent().remove();
    $(`#item_images_attributes_${targetIndex}_image`).remove();
    $(".flexbox").append(`<input class="file-field" type="file" name="item[images_attributes][${targetIndex}][image]" id="item_images_attributes_${targetIndex}_image">`);
  })
  var buildImage = function(url){
    if(index.length != 0){
      $(".new-contents__box__preview").append(`
        <div class="new-contents__box__preview__image">
        <img class="new-contents__box__preview__image__img" src="${url}">
        <div class="delete" index=${index[0]}>削除</div>
      `);
      $(".flexbox").append(`<input class="file-field" type="file" name="item[images_attributes][${index[1]}][image]" id="item_images_attributes_${index[1]}_image">`);
      $("#image-label").attr("for",`item_images_attributes_${index[1]}_image`);
      index.shift();
      if(index.length > 5){
        $("#image-field-second").remove();
        $(".new-contents__box__image-area").css("display","flex");
        $(".new-contents__box__image-area").css("width",(index.length-5)*130);
      }else if(index.length == 5){
        $(".new-contents__box__image-area").css("display","none");
        $("#image-label").append(`
          <div class="new-contents__box__image-area" id="image-field-second">
            <i class="fas fa-camera"></i>
            <div class="new-contents__box__image-area__text">
              ドラッグアンドドロップ
              <br>
              またはクリックしてファイルをアップロード
            </div>
          </div>
        `);
        $(".new-contents__box__preview").attr("class", "new-contents__box__preview-first");
        $(".new-contents__box__preview-first").after(`<div class="new-contents__box__preview"></div>`);
      }else if(index.length == 0){
        $("#image-field-second").css("display","none");
      }
      $("#image-field-second").css("width",index.length*130);
    }
  }
  $(".flexbox").on("change", function(e){
    var blob = window.URL.createObjectURL(e.target.files[0]);
    buildImage(blob);
  })
})