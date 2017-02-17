class Users::RegistrationsController < Devise::RegistrationsController
  before_action :select_plan, only: :new
  def create
    super do |resource|
      if params[:plan]
        resource.plan_id == params[:plan]
        puts resource
        if resource.plan_id == 2
          resource.save_with_subscription
        else
          resource.save
        end
      end
    end
  end

  private

  def select_plan
    unless(params[:plan] == 'Basic' || params[:plan] == 'Premium')
      flash[:notice]= "Plese select a plan"
      redirect_to root_url
    end
  end
end
