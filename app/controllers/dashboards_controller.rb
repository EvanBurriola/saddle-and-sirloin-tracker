# OATH
class DashboardsController < ApplicationController
  def show
    # Redirect the user to the create a profile page if
    # the Oauth admin email doesn't exist as a User!
    user = User.find_by(email: current_admin.email)
    if user.nil?
      redirect_to(controller: 'users', action: 'new')
    elsif user.isActive == false
      redirect_to(controller: 'users', action: 'waiting')
      user.isRequesting = true
      user.save
    end
  end

  # FOR TESTING! REMOVE
  def swapRole
    @user = User.find_by(email: current_admin.email)
    @user.role = @user.role == 1 ? 0 : 1
    @user.save
    redirect_to '/'
  end
end
