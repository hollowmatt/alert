class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def to_s
    "#{email} (#{admin? ? 'Admin' : 'User'})"
  end

  def user_type
    admin? ? 'Admin' : 'User'
  end

  def create_date
    created_at.getlocal.strftime("%B %d at %I:%M %p")
  end

  def last_log_in
    last_sign_in_at? ? last_sign_in_at.getlocal.strftime("%B %d at %I:%M %p") : 'never logged in'
  end
end
