# require 'send_emails_job'
class UsersController < ApplicationController
    # before_action :set_user, only: %i[ show edit update destroy]
    before_action :set_user, only: [:send_welcome_email]


    def index
      @users = User.all
      #  respond_to do |format|
      #         format.html { redirect_to @users }
              # format.json { render json: @users }
      # end
    end
  
    def show
      @user = User.find(params[:id])
    end
  
    def new
      @user = User.new
    end
  
    def edit
    end
  
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user
    else
      render json: {status: :created}
    end
  
    # respond_to do |format|
    #   if @user.save
    #     UserMailer.welcome_email(@user).deliver_now
    #     format.html { redirect_to user_url(@user), notice: "User was successfully created." }
    #     format.json { render :show, status: :created, location: @user }
    #   else
    #     format.html { render :new, status: :unprocessable_entity }
    #     format.json { render json: @user.errors, status: :unprocessable_entity }
    #   end
    # end
  end
  
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_url(@user), notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  
    def destroy
      @user.destroy
  
      respond_to do |format|
        format.html { redirect_to users_url, notice: "User was successfully destroyed." }
        format.json { head :no_content }
      end
    end
    
    def send_welcome_email
      user = User.find(params[:id])
      SendEmailsJob.set(wait: 2.minutes).perform_later(user)
      flash[:notice] = "Welcome email will be sent to #{user.email} in a week."
      redirect_to url_for('/')
    end
  
    private
      def set_user
        @user = User.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        flash[:alert] = "User not found"
        redirect_to url_for('/')
      end
  
      def user_params
        params.require(:user).permit(:name, :email)
      end
end 
