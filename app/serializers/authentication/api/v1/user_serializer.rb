class Authentication::Api::V1::UserSerializer < Authentication::Api::V1::BaseSerializer
  attributes :id, :email, :fullname

  def fullname
    "#{object.firstname} #{object.lastname}"
  end
end
