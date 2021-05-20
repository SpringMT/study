namespace :task do
  def a(stage, app)
    p stage
    p app
  end

  desc "Run rubocop on staged files on git"
  task :exec, [:stage, :app] do |_t, args|
    p _t
    stage = args[:stage] || "dev_local"
    app = args[:app]
    a(stage, app)
  end

end
