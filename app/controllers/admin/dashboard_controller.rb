class Admin::DashboardController < ApplicationController
  http_basic_authenticate_with name: ENV['ADMIN_NAME'], password: ENV["ADMIN_PASSWORD"]
  
  def show
    @products_nb = Product.all.count
    @categories_nb = Category.all.count
  end
end
