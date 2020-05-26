# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController

  def new
    @user = User.new
  end
 

  def create
    @user = User.new(sign_up_params)
    unless @user.valid?
      render :new and return
    end
      session["devise.regist_data"] = {user: @user.attributes}
      session["devise.regist_data"][:user]["password"] = params[:user][:password]
      @address = @user.addresses.build
      render :new_address
    end
  

  # def new_address
  #   @user = User.new(session["devise.regist_data"]["user"])
  #   @address = Address.new
  # end  

  def create_address
    @user = User.new(session["devise.regist_data"]["user"])
    @address = Address.new(address_params)
    unless @address.valid?
      render :new_address and return
    end
      @user.addresses.build(@address.attributes)
      @user.save
      session["devise.regist_data"]["user"].clear
      sign_in(:user, @user)
  end


  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  def address_params
    params.require(:address).permit(:post_number, :prefecture_id, :city, :address, :apartment)
  end

end
