require 'net/http'
class EmailsController < ApplicationController

  skip_before_filter :authenticate_user

  def create
    Notifier.receive(params['body-mime'])
    render nothing: true
  end

  #TODO Should this method be here?
  def create_route
    data[:priority] = 0
    data[:description] = "Sample route"
    data[:expression] = "match_recipient('.*@#{Site.current.email_host}')"
    data[:action] = ["forward('http://#{Site.current.host}/email/')", "stop()"]
    post "https://api:#{Site.current.mailgun_apikey}"\
    "@api.mailgun.net/v2/routes", data
  end

end
