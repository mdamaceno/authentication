class Authentication::Api::V1::SessionSerializer < Authentication::Api::V1::BaseSerializer
  attributes :id, :email, :fullname, :role, :token

  def token
    object.authentication_token
  end

  def fullname
    "#{object.firstname} #{object.lastname}"
  end
end
