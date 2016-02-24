module Authentication
  class Api::V1::UsersSerializer < Authentication::Api::V1::BaseSerializer
    attributes :id, :name, :email
  end
end
