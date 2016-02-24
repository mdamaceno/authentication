require 'test_helper'

module Authentication
  class Api::V1::UsersSerializerTest < ActionController::TestCase
    def setup
      @resource = build(:user)
      @serializer = Authentication::Api::V1::UsersSerializer.new(@resource)
      @serialization = ActiveModel::Serializer::Adapter.create(@serializer)
      @data = JSON.parse(@serialization.to_json)
      @attribute = @data['data']['attributes']
    end

    test 'has an id' do
      assert_equal @resource.id, @attribute['id']
    end

    test 'has a name' do
      assert_equal @resource.name, @attribute['name']
    end

    test 'has a email' do
      assert_equal @resource.email, @attribute['email']
    end
  end
end
