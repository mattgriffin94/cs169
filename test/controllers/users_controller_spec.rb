

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should add user" do
    assert_difference('User.count') do
      post :create, user: { logins: @user.logins, name: @user.name, password: @user.password }
    end

    assert_redirected_to user_path(assigns(:user))
  end

    test "should add 2 users" do
        assert_difference('User.count',2) do
            post :create, user: { logins: @user.logins, name: @user.name, password: @user.password }
            post :create, user: { logins: @user.logins, name: @user.name, password: @user.password }
        end
        
        assert_redirected_to user_path(assigns(:user))
    end

  test "should show user" do
    get :show, id: @user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user
    assert_response :success
  end

  test "should update user" do
    patch :update, id: @user, user: { logins: @user.logins, name: @user.name, password: @user.password }
    assert_redirected_to user_path(assigns(:user))
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, id: @user
    end

    assert_redirected_to users_path
  end

test "should reset" do
    post :create, user: { logins: @user.logins, name: @user.name, password: @user.password }
    post :reset, :format => :json
    assert_equal(User.count,0)
    
end

test "test user login" do
    post :create, user: { logins: @user.logins, name: @user.name, password: @user.password }
    assert_equal(@user.logins,1)
    
end





end
