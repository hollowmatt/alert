class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :roles
         
  scope :excluding_archived, lambda { where(archived_at: nil) }

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

  def archive
    self.update(archived_at: Time.now)
  end

  def active_for_authentication?
    super && archived_at.nil?
  end

  def inactive_message
    archived_at.nil? ? super : :archived
  end

  def role_on(platform)
    roles.find_by(platform_id: platform).try(:name)
  end

end
