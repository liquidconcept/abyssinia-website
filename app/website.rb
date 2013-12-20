# encoding: utf-8
require 'pony'
require 'sinatra'
require 'sinatra/base'
require 'sinatra/activerecord'

require File.expand_path('../../config/application', __FILE__)
require File.expand_path('../../config/nanoc', __FILE__)
require File.expand_path('../../config/compass', __FILE__)

include Nanoc::Helpers::Sprockets

configure do
  @@config = YAML.load_file(File.expand_path('../../config/settings.yml', __FILE__)) rescue {}
end

module Application
  class Website < Sinatra::Base
    set :static, true
    set :public_folder, File.expand_path('../../public', __FILE__)

    # Contact form
    post '/contact' do
      template = ERB.new(File.read(File.expand_path('../templates/contact.text.erb', __FILE__), :encoding => 'UTF-8'))

      Pony.mail(
        :from     => params[:message_request][:email],
        :to       => COMMAND_EMAIL_TO,
        :charset  => 'utf-8',
        :subject  => COMMAND_SUBJECT,
        :body     => template.result(binding)
      )

      redirect "/contact.html"
    end
  end

  class Admin < Sinatra::Base
    use Rack::MethodOverride

    use Rack::Auth::Basic, "Protected Area" do |username, password|
      username == @@config['basic_auth']['username'] && password == @@config['basic_auth']['password']
    end

    get '/' do
      @news = New.all

      erb :"admin/index"
    end

    put '/publish' do

      system 'rm public/index.html'
      system 'bundle exec nanoc compile'

      redirect '/admin'
    end
  end
end
