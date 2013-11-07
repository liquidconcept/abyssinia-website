# encoding: utf-8
require 'sinatra/base'
require 'pony'

require File.expand_path('../../config/application', __FILE__)

module Application
  class Website < Sinatra::Base
    set :static, true
    set :public_folder, File.expand_path('../../public', __FILE__)

    # Contact form
    post '/index' do
      template = ERB.new(File.read(File.expand_path('../templates/contact.text.erb', __FILE__), :encoding => 'UTF-8'))

      Pony.mail(
        :from     => params[:message_request][:mail],
        :to       => COMMAND_EMAIL_TO,
        :charset  => 'utf-8',
        :subject  => params[:message_request][:subject],
        :body     => template.result(binding)
      )
      redirect "/"
    end
  end
end