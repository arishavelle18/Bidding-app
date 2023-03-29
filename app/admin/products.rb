ActiveAdmin.register Product do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
 
  permit_params :id,:image,:product_name, :description, :lowest_allowable_bid, :starting_bid_price, :bidding_expiration, :user_id, :stop_switch
  
  index do
    selectable_column
    id_column
    column :id
    column :image do |product|
      product.image.present? ? cl_image_tag(product.image , :width=>200, :crop=>"fill") :  cl_image_tag("no_rpqcih" , :width=>200, :crop=>"fill") 
    end
    column :product_name
    column :description
    column :lowest_allowable_bid
    column :starting_bid_price
    column :bidding_expiration
    column :user_id
    column :stop_switch
    actions
  end


  
  # if you click the id it will show the details about the product
  show do
    attributes_table do
      row :id
      row :image do |product|
        product.image.present? ? cl_image_tag(product.image , :width=>200, :crop=>"fill") :  cl_image_tag("no_rpqcih" , :width=>200, :crop=>"fill") 
      end
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
      # check if image is presented or not and this form is targeting create and edit form
      if f.object.image.present?
        f.input :image, as: :file, hint: cl_image_tag(f.object.image , :width=>200, :crop=>"fill")
      else
        f.input :image, as: :file
      end
      f.input :product_name
      f.input :description
      f.input :lowest_allowable_bid
      f.input :starting_bid_price
      f.input :bidding_expiration
      f.input :stop_switch
    end
    f.actions
  end
  
  # createe controllerr for submiting form
  controller do
    # for adding cloudinary/image in the admin 
    def create
      # pass to product model
      @product = Product.new(permitted_params[:product])
      if @product.valid?
        if !params[:product][:image].nil?
          result =  Cloudinary::Uploader.upload(params[:product][:image])
          @product.image = result["public_id"]
        end
        @product.save
        redirect_to admin_product_path(@product), notice: 'Product was successfully created.'
      else
        render :new
      end
    end
    def update
      @product = Product.find(params[:id])
      Cloudinary::Uploader.destroy(@product.image) if params[:product][:image]
      if @product.update(permitted_params[:product])
        if !params[:product][:image].nil?
          result =  Cloudinary::Uploader.upload(params[:product][:image])
          @product.update_attribute(:image,result["public_id"])
        end
        @product.update(stop_switch:!@product.stop_switch) if @product.stop_switch
        redirect_to admin_product_path(@product), notice: 'Product was successfully updated.'
      else
        render :edit
      end
    end
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
