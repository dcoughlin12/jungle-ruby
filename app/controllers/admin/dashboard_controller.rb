class Admin::DashboardController < ApplicationController
  # http_basic_authenticate_with name: "dhh", password: "secret"
  http_basic_authenticate_with name: ENV['ADMIN_USERNAME'], password: ENV['ADMIN_PASSWORD']
  def show
  end
end
