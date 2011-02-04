require 'test_helper'

class PetitionsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:petitions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create petition" do
    assert_difference('Petition.count') do
      post :create, :petition => { }
    end

    assert_redirected_to petition_path(assigns(:petition))
  end

  test "should show petition" do
    get :show, :id => petitions(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => petitions(:one).to_param
    assert_response :success
  end

  test "should update petition" do
    put :update, :id => petitions(:one).to_param, :petition => { }
    assert_redirected_to petition_path(assigns(:petition))
  end

  test "should destroy petition" do
    assert_difference('Petition.count', -1) do
      delete :destroy, :id => petitions(:one).to_param
    end

    assert_redirected_to petitions_path
  end
end
