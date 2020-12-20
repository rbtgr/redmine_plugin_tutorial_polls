require File.expand_path('../../test_helper', __FILE__)

class PollsControllerTest < ActionController::TestCase
  fixtures :projects, :users
  plugin_fixtures :polls

  def test_index
    # プロジェクトメンバーのセッション
    @request.session[:user_id] = 2

    # ロールに権限を追加
    Role.find(1).add_permission! :view_polls

    # 特定のモジュールの有効/無効を切り替える
    #roject.find(1).enabled_module_names = [:mymodule]

    get :index, :params => {project_id: 1}
    assert_response :success
    assert_template 'index'
  end

  def test_vote
    @request.session[:user_id] = 2
    Role.find(1).add_permission! :view_polls, :vote_polls

    post :vote, :params => {id: 1, answer: 'yes' }
    assert_redirected_to "/polls"

    get :index, :params => {project_id: 1}
    assert_include 'Yes</a> (1)', response.body
  end
end
