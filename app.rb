
require 'bundler/setup'
ENV['RACK_ENV'] ||= 'development'
Bundler.setup :default, ENV['RACK_ENV'].to_sym

$LOAD_PATH.unshift File.dirname(__FILE__)
$LOAD_PATH.unshift(File.dirname(__FILE__) + '/lib')

require 'sinatra'
require 'json'
require 'vatin'

#
class App < Sinatra::Application
  configure do
    ENV['TZ'] = 'UTC'
    disable :show_errors
    # TODO: caching, server-side

    set :awesomes, (ENV['AWESOMES'] || '').split(',')

    helpers do
      def error(msg)
        { error: { message: msg } }.to_json
      end
    end
  end

  before '/api/*' do
    cache_control :public, max_age: 28_800
    content_type 'application/json'
    response.headers['X-Version'] = VATIN::VERSION
  end

  error ArgumentError do
    e = env['sinatra.error']
    status 400
    { error: { message: e.message } }.to_json
  end

  not_found do
    status 404
    { error: { message: 'Resource not found or country not supported yet.' } }.to_json
  end

  error do
    status 500
    { error: { message: 'Server error.' } }.to_json
  end

  # Get a VAT identification number for a business entity in a given country.
  #
  # @method get_api_vat_number
  # @overload get '/api/:country/:id'
  # @param [String] :country
  # @param [String] :id
  #
  # @return [JSON]
  #
  get '/api/:country/?:id?' do
    halt 404 unless VATIN::SUPPORTED_COUNTRIES.include? params[:country]
    halt 400, error('Missing company id.') unless params[:id]

    rep = VATIN.get(params[:country].upcase, params[:id])
    rep['awesome'] = true if App.settings.awesomes.include? rep[:vat]
    rep.to_json
  end

  #
  # @method get_api
  # @overload get '/api/'
  # @return [JSON]
  #
  get '/api/' do
    {
      name: 'VATIN',
      summary: 'Return a VAT Identification Number from Company Id and Country.',
      version: VATIN::VERSION,
      supported: VATIN::SUPPORTED_COUNTRIES.join(', '),
      source: 'https://github.com/hupstream/vatin'
    }.to_json
  end

  # Home page
  #
  # @method get_home
  # @overload get '/'
  #
  get '/' do
    # TODO: human-facing stuff
  end

end
