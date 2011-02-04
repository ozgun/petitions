module Admin::UsersHelper

  def activation_status_icon(user)
    if user.active?
      image_tag "active.png", :alt => t('active'), :title => t('active')
    else
      image_tag "inactive.png", :alt => t('inactive'), :title => t('inactive')
    end
  end

  def suspension_status_icon(user)
    if user.suspended?
      image_tag "suspended.png", :alt => t('suspended'), :title => t('suspended')
    else
      image_tag "unsuspended.png", :alt => t('unsuspended'), :title => t('unsuspended')
    end
  end

  def suspension_status_update_link(user)
    if user.suspended?
      link_to t('unsuspend'), unsuspend_admin_user_path(user), :method => :put, :confirm => t('are_you_sure')
    else
      link_to t('suspend'), suspend_admin_user_path(user), :method => :put, :confirm => t('are_you_sure')
    end
  end

  def admin_indicatior_icon(user)
    if user.admin?
      image_tag "admin.png", :alt => t('admin'), :title => t('admin')
    end
  end

end
