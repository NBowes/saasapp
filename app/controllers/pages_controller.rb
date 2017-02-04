class PagesController < ApplicationController
  def home
    @basic_plan = Plan.find(1)
    @preimum_plan = Plan.find(2)
  end

  def about
  end
end
