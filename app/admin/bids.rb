ActiveAdmin.register Bid do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :bid_value, :user_id, :product_id

  form do |f|
    f.semantic_errors *f.object.errors.attribute_names
    f.inputs do 
      f.input :bid_value
      f.input :user_id, :label => "User", :as => :select, :collection => User.where(is_admin:false).all.map{|c| [c.full_name, c.id]}
      f.input :product_id, :label => "Product", :as => :select, :collection => Product.all.map{|c| [c.product_name, c.id]}
    end
    f.actions
  end

  controller do
    def check_value(value)


    end
  end

  #
  # or
  #
  # permit_params do
  #   permitted = [:bid_value, :user_id, :product_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
