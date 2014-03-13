class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # todo signin & redirect to users#show
      sign_in user
      redirect_to user
    else
      # show error message
      flash.now[:error] = 'invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_dir
  end
end
