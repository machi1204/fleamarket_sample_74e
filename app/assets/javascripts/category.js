$(function(){
  // カテゴリーセレクトボックスのオプションを作成
  function categoryOption(category){
    var optionHtml = `<option value = "${category.id}">${category.name}</option>`;
    return optionHtml;
  }

  // 親カテゴリー選択後のイベント
  $('#category-select-parent').on('change', function(){
    let parentCategoryId = $(this).val();
    if (parentCategoryId == ''){
      $('#select-children-box').remove();
      $('#select-grandchildren-box').remove();
    }else{
      $.ajax({
        url: '/items/category_children',
        type: 'GET',
        data: { parent_id: parentCategoryId },
        dataType: 'json'
      })
      .done(function(category_children){
        $('#select-children-box').remove();
        $('#select-grandchildren-box').remove();
        let optionHtml = '';
        category_children.forEach(function(child){
          optionHtml += categoryOption(child);
        });
        $('#error-category').before(`<div class="new-contents__box__select" id="select-children-box">
                                      <label class="new-contents__box__select__label" for="item_category_id">
                                        <select class="new-contents__box__select__input" id="category-select-children" required="required" name="item[category_id]">
                                          <option value="">選択して下さい</option>
                                          ${optionHtml}
                                        </select>
                                      </label>
                                    </div>`
        );
      })
      .fail(function(){
        alert('カテゴリー取得に失敗しました');
      });
    }
  });

  // 子カテゴリー選択後のイベント
  $('.new-contents__box__details').on('change', '#category-select-children', function(){
    let childrenCategoryId = $(this).val();
    if (childrenCategoryId == ''){
      $('#select-grandchildren-box').remove();
    }else{
      $.ajax({
        url: '/items/category_grandchildren',
        type: 'GET',
        data: { child_id: childrenCategoryId },
        dataType: 'json'
      })
      .done(function(category_grandchildren){
        $('#select-grandchildren-box').remove();
        let optionHtml = '';
        category_grandchildren.forEach(function(grandchildren){
          optionHtml += categoryOption(grandchildren);
        });
        $('#error-category').before(`<div class="new-contents__box__select" id="select-grandchildren-box">
                                       <label class="new-contents__box__select__label" for="item_category_id">
                                        <select class="new-contents__box__select__input" id="category-select-grandchildren" required="required" name="item[category_id]">
                                          <option value="">選択して下さい</option>
                                          ${optionHtml}
                                        </select>
                                       </label>
                                     </div>`
        );
      })
      .fail(function(){
        alert('カテゴリー取得に失敗しました');
      });
    }
  });

  $(function(){
    function appendSizeOption(size){
      var html = `<option value="${size.id}">${size.size}</option>`;
      return html;
    }

    function appendSizeBox(insertHTML){
      var sizeSelectHtml = '';
      sizeSelectHtml = `<div class="new-contents__box__select" id="size_wrapper">
                          <label class="new-contents__box__select__label" for="サイズ">
                            <select class="new-contents__box__select__input" id="size" required="required" name="item[item_size_id]">
                              <option value="">選択して下さい</option>
                              ${insertHTML}
                            </select>
                          </label>
                        </div>`;
      $('.new-contents__box__details').append(sizeSelectHtml);                         
    }
    $('.new-contents__box__details').on('change', '#category-select-grandchildren', function(){
      let grandchildrenCategoryId = $(this).val();
      if (grandchildrenCategoryId != ""){
      $.ajax({
        url: '/items/get_size',
        type: 'GET',
        data: { grandchild_id: grandchildrenCategoryId },
        dataType: 'json'
      })
      .done(function(sizes){
        $('#size_wrapper').remove();
        if (sizes.length != 0) {
          var insertHTML = '';
            sizes.forEach(function(size){
              insertHTML += appendSizeOption(size);
            });
            appendSizeBox(insertHTML);
        }
      })
      .fail(function(){
        alert('サイズ取得に失敗しました');
      })
    }else{
      $('#size_wrapper').remove();
    }
  });

  });
});