# encoding: utf-8
require 'pony'
require 'sinatra'
require 'csv'
require 'sinatra/base'
require 'sinatra/activerecord'
require './app/models/email'
require './app/models/news_text'

require File.expand_path('../../config/application', __FILE__)
require File.expand_path('../../config/nanoc', __FILE__)
require File.expand_path('../../config/compass', __FILE__)

include Nanoc::Helpers::Sprockets

configure do
  @@config = YAML.load_file(File.expand_path('../../config/settings.yml', __FILE__)) rescue {}
end

set :database, "sqlite3:///db/database.sqlite3"

module Application
  class Website < Sinatra::Base
    set :static, true
    set :public_folder, File.expand_path('../../public', __FILE__)

    # Contact form
    post '/contact' do
      template = ERB.new(File.read(File.expand_path('../templates/contact.text.erb', __FILE__), :encoding => 'UTF-8'))

      email = params[:message_request][:email]

      Email.create!(email: email) unless Email.where(email: email).exists?

      Pony.mail(
        :from     => email,
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
      @emails = Email.order(email: :desc)
      @news_texts = News_text.all

      erb :"admin/index"
    end

    post '/news' do
      news_text = params[:news_request][:news_text]

      News_text.create!(news_text: news_text)

      #generate
      system 'rm public/index.html'
      system 'touch tmp/restart.txt'
      system 'bundle exec nanoc compile'

      redirect '/admin'
    end

    get '/emails.csv' do
      headers 'Content-Type' => 'text/csv', 'Content-Disposition' => 'attachment; filename="emails.csv"'

      CSV.generate do |csv| #a+ = add / w = rewrite
        Email.all.each do |email|
          csv << [email.email]
        end
      end
    end

    get '/delete' do
      email = params[:email_request][:email]

      if Email.where(email: email).exists?
        @status_report = "l'email #{email} a été supprimer de la liste"
        Email.where(email: email).destroy_all
      else
        @status_report = "l'email #{email} n'existe pas"
      end

      erb :"admin/index"
    end
  end
end
