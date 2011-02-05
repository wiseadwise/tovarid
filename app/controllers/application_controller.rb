class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_download_link
  def set_download_link
    @download_link = 'http://www.upcode.mobi/'
  end
end
