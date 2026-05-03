class ApplicationController < ActionController::Base
  include Authentication

  allow_browser versions: :modern

  before_action :resume_session

  require 'net/http'
  require 'json'
end
