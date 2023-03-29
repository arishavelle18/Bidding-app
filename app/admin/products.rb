ActiveAdmin.register Product do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
 
  permit_params :id,:product_name, :description, :lowest_allowable_bid, :starting_bid_price, :bidding_expiration, :user_id, :stop_switch
  
  
  # if you click the id 
  show do
    attributes_table do
      row :id
      row :product_name
      row :description
      row :lowest_allowable_bid
      row :starting_bid_price
      row :bidding_expiration
      row :winner
      row :stop_switch
    end
    render partial: 'admin/partials/bidders', locals: { product: product }
  end
  # add form 

  form do |f|
    f.semantic_errors *f.object.errors.attribute_names
    f.inputs do
      f.input :user_id, :label => "User", :as => :select, :collection => User.where(is_admin:true).all.map{|c| [c.full_name, c.id]}
      f.input :product_name
      f.input :description
      f.input :lowest_allowable_bid
      f.input :starting_bid_price
      f.input :bidding_expiration
      f.input :stop_switch
    end
    f.actions
  end

  #
  # or
  #
  # permit_params do
  #   permitted = [:product_name, :description, :lowest_allowable_bid, :starting_bid_price, :bidding_expiration, :user_id, :stop_switch]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
