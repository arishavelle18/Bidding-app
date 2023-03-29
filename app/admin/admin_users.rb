ActiveAdmin.register AdminUser do
  permit_params :full_name,:email, :password, :password_confirmation

  index do
    selectable_column
    id_column
    column :email
    column :created_at
    actions
  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

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

end
