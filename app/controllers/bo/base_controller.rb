class Bo::BaseController < ApplicationController
  layout 'application_bo'
  before_filter :require_user
end