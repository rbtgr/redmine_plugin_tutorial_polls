Redmine::Plugin.register :polls do
  name 'Polls plugin'
  author 'rgtgr'
  description 'Polls'
  version '0.0.1'
  url 'https://github.com/rbtgr/redmine_plugin_tutorial_polls'
  author_url 'https://github.com/rbtgr'


  # アプリケーションメニューに追加
  # menu :application_menu, :polls, { controller: 'polls', action: 'index' }, caption: 'Polls'

  # プロジェクトメニューに追加
  permission :polls, { polls: [:index, :vote] } # , public: true
  menu(
    :project_menu,
    :polls,
    { controller: 'polls', action: 'index' },
    caption: :label_poll,
    after: :activity,
    param: :project_id
  )

  permission :view_polls, polls: :index # 表示権限
  permission :vote_polls, polls: :vote  # 投票権限

  # プロジェクトモジュール「Polls」を作成
  project_module :polls do
    permission :view_polls, polls: :index
    permission :vote_polls, polls: :vote
  end

  # ビューフック呼び出し
  #　/var/lib/redmine/plugins/polls/lib/polls_hook_listener.rb
  require_dependency 'polls_hook_listener'

  # プラグイン設定の追加
  # Setting.plugin_polls で利用できる
  settings default: {'empty' => true}, partial: 'settings/poll_settings'
end
