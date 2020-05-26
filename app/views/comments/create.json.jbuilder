json.text  @comment.comment
json.user_id  @comment.user.id
json.user_name  @comment.user.nickname
json.time  @comment.created_at.strftime("%Y-%m-%d %H:%M:%S")
json.item_user_id  @item.user_id