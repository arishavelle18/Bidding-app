ActiveAdmin.register User do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
    permit_params :full_name, :email, :password,:password_confirmation, :is_admin

    form do |f|
      f.semantic_errors *f.object.errors.attribute_names
      f.inputs do
        f.input :full_name
        f.input :email
        f.input :password
        f.input :password_confirmation
        f.input :is_admin
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
