class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  belongs_to :plan
  has_one :profile
  attr_accessor :stripe_token

  def save_with_subscription
      if valid?
        customer = Stripe::Customer.create(description: email, plan: plan_id, card: stripe_token)
        self.stripe_user_token = customer.id
        save!
      end
  end
end
