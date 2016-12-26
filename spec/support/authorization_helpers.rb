module AuthorizationHelpers
  def assign_role!(user, role, platform)
    Role.where(user: user, platform: platform).delete_all
    Role.create(user: user, role: role, platform: platform)
  end

  RSpec.configure do |c|
    c.include AuthorizationHelpers
  end

end