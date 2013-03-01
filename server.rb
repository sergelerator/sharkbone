require 'sinatra'
require 'haml'

set :public_folder, File.dirname(__FILE__)

get '/', provides: 'html' do
  haml :spec_runner
end
