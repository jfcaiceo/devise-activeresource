class ActiveSupport::TestCase
  setup do
    User.destroy_all
    Admin.destroy_all
  end
end
