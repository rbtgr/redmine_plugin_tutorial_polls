class PollsHookListener < Redmine::Hook::ViewListener
  # 画面左側にコンテンツを追加
  # def view_projects_show_left(context = {})
  #   return content_tag("p", "Custom content added to the left")
  # end

  # 画面の右側にコンテンツを追加
  def view_projects_show_right(context = {})
    return content_tag("p", "Custom content added to the right")
  end

  # テンプレートを使用したフック
  # app/views/polls/_project_overview.html.erb を左側に追加
  render_on :view_projects_show_left, partial: "polls/project_overview"

end
