require 'zeus/rails'

class CustomPlan < Zeus::Rails
  def test(*args)
    require 'simplecov'
    SimpleCov.start 'rails'
    ENV['GUARD_RSPEC_RESULTS_FILE'] = 'tmp/guard_rspec_results.txt'
    Dir["#{Rails.root}/app/**/*.rb"].each { |f| load f }
    Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }
    super
  end

  def teaspoon_console
    require 'teaspoon/console'
    @console = ::Teaspoon::Console.new({})
  end

  def teaspoon(argv = ARGV)
    @console.execute(argv[0])
  end
end

Zeus.plan = CustomPlan.new
