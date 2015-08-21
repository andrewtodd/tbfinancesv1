require 'test_helper'

class TennantsControllerTest < ActionController::TestCase
  setup do
    @tennant = tennants(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tennants)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tennant" do
    assert_difference('Tennant.count') do
      post :create, tennant: { email: @tennant.email, first_name: @tennant.first_name, last_name: @tennant.last_name, notes: @tennant.notes, phone: @tennant.phone, property_id: @tennant.property_id }
    end

    assert_redirected_to tennant_path(assigns(:tennant))
  end

  test "should show tennant" do
    get :show, id: @tennant
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @tennant
    assert_response :success
  end

  test "should update tennant" do
    patch :update, id: @tennant, tennant: { email: @tennant.email, first_name: @tennant.first_name, last_name: @tennant.last_name, notes: @tennant.notes, phone: @tennant.phone, property_id: @tennant.property_id }
    assert_redirected_to tennant_path(assigns(:tennant))
  end

  test "should destroy tennant" do
    assert_difference('Tennant.count', -1) do
      delete :destroy, id: @tennant
    end

    assert_redirected_to tennants_path
  end
end
