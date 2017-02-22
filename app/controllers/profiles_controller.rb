class ProfilesController < ApplicationController

  def new
    @profile = Profile.new
  end

  def create
    @user = User.find(params[:user_id])
    @profile = @user.build_profile(profile_params)
      if @profile.save
        flash[:success] = 'Profile created!'
        redirect_to user_path(params[:user_id])
      else
        flash[:danger] = "Error saving profile. #{@profile.errors.full_messages.join(', ')}"
        render action: :new
      end
  end

  private
  def profile_params
    params.require(:profile).permit(:first_name, :last_name, :avatar, :job_title, :phone_number,:contact_email, :description)
  end
end
