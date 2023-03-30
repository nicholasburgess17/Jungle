class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.authenticate_with_credentials(params[:email], params[:password])
    if user
      # success logic, log them in
      session[:user_id] = user.id
      redirect_to '/'
    else
      # error logic, show an error message
      # flash.now[:alert] = "Invalid email/password combination"
      # render :new
        
      # failure, redirect to login form
      # Note: this line is moved inside the else block
      # and will only be executed if the user is not authenticated
      # and the `else` block is executed.
      # Otherwise, it will never be executed.
      redirect_to '/login'
    end
  end
    
      def destroy
        session[:user_id] = nil
        redirect_to '/login'
      end
    end