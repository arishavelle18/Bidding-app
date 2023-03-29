ActiveAdmin.register User do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
    permit_params :id,:full_name, :email, :password,:password_confirmation,:created_at,:updated_at
   
    index do
      selectable_column
      id_column
      column :full_name
      column :email
      column :password_digest
      actions
    end
    show do
      attributes_table do
        row :id
        row :full_name
        row :email
        row :password_digest
        row :created_at
        row :updated_at
      end
      
    end
    

    form do |f|
      f.semantic_errors *f.object.errors.attribute_names
      f.inputs do
        f.input :full_name
        f.input :email
        f.input :password
        f.input :password_confirmation
      end
      f.actions
    end
  #
  # or
  #
  # permit_params do
  #   permitted = [:full_name, :email, :password_digest, :is_admin]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
