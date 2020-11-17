class Admin::DashboardController < Admin::BaseAdminController
  
  def show
    @products_nb = Product.all.count
    @categories_nb = Category.all.count
  end
end
