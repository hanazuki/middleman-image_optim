module TestApplication
  def middleman
    ENV['MM_ROOT'] = File.join(__dir__, '../../example')
    @middleman ||= Middleman::Application.new do
      config[:mode] = :build
      config[:show_exceptions] = false
    end
  end

  def app
    @app ||= Middleman::Rack.new(middleman).to_app
  end
end
