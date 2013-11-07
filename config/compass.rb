# encoding: utf-8
# Require any additional compass plugins here.
# Set this to the root of your project when deployed:

project_path    = '.'

http_path             = '/'
http_stylesheets_path = '/assets/stylesheets'
http_javascripts_path = '/assets/javascripts'
http_images_path      = '/assets/images'

images_dir            = 'content/assets/images'

output_style    = ENV['RACK_ENV'] != 'production' ? :nested : :compressed

sass_options = {
  :syntax => :scss
}
