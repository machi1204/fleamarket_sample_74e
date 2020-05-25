$(function(){
  let index = [0,1,2,3,4,5,6,7,8,9];
  let request = $("#image-label").attr("action");
  //editアクションでajaxで画像を拾ってくる
  if(request != undefined && request.indexOf("edit") != -1){
    $.ajax({
      url: "/items/set_images",
      data: {id:request.replace(/[^0-9]/g, '')},
      dataType: "json"
    }).done(function(data){
      data.images.forEach(function(d){
        buildImage(d.image.url);
      })
      $(".hidden").hide();
      //編集で削除したとき
      $(".flexbox").on("click", ".delete", function(){
        let targetDeleteIndex = Number($(this).attr("index"));
        $(`#item_images_attributes_${targetDeleteIndex}__destroy`).prop('checked', true);
      })
    })
  }
  //削除ボタンを押すと発火
  $(".flexbox").on("click", ".delete", function(){
    $(document).on('page:load', 'ready')
    let targetIndex = Number($(this).attr("index"));
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
    $(this).parent().remove();
    $(`#item_images_attributes_${targetIndex}_image`).remove();
    $(".flexbox").append(`<input class="file-field" type="file" name="item[images_attributes][${targetIndex}][image]" id="item_images_attributes_${targetIndex}_image">`);
  })
  //関数１ 画像エリアを作成
  let buildImage = function(url){
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
  //画像を追加すると発火 関数１へ
  $(".flexbox").on("change", function(e){
    let blob = window.URL.createObjectURL(e.target.files[0]);
    buildImage(blob);
  })
})