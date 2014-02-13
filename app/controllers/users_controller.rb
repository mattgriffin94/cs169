class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end
  
  def add
      
     @name = params[:user]
     @password = params[:password]
      
     if User.where(:name => @name).blank?
         
         if @name.length > 128 or @name.length == 0
             #bad username
             respond_to do |format|
                 msg = { :errCode => -3 }
                 format.json { render :json => msg }
              end
          elsif @password.length > 128
              #bad password
              respond_to do |format|
                  msg = { :errCode => -4 }
                  format.json { render :json => msg }
              end
          else
             User.create(:name => @name,
                         :password => @password,
                         :logins => 1)
             respond_to do |format|
                 msg = { :errCode => 1, :count => 1 }
                 format.json { render :json => msg }
                 redirect_to root_url, notice: "You have successfully logged out."
             end
          end
      else
          #user already exists
          respond_to do |format|
              msg = { :errCode => -2 }
              format.json { render :json => msg }
          end
     end
      
  end
  
  def login
      
      @name = params[:user]
      @password = params[:password]
      
      if User.where(:name => @name).blank?
          #user doesnt exists
          respond_to do |format|
              msg = { :errCode => -1 }
              format.json { render :json => msg }
          end
      else
      
        @user = User.where(:name => @name).first
         if @user.password == @password
             @user.increment(:logins,by = 1)
             @user.save
             respond_to do |format|
                 msg = { :errCode => 1, :count => @user.logins }
                 format.json { render :json => msg }
             end
         else
             #wrong password
             respond_to do |format|
                 msg = { :errCode => -1 }
                 format.json { render :json => msg }
             end
         end
       end
    end
  
  
  

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :password, :logins)
    end
end
