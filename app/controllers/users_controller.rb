class UsersController < ApplicationController
  before_filter :set_class, :authorize_or_redirect
  # GET /contents
  # GET /contents.json
  

  # GET /contents/1/edit
  def edit
    @content = User.find(params[:id])
  end

  
  def update
    @content = User.find(params[:id])

    respond_to do |format|
      if params[:user][:password].blank?
        params[:user].delete(:password)
        params[:user].delete(:password_confirmation)
      end
      if @content.update_attributes(params[:user])
        format.html { redirect_to admin_url, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @content.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contents/1
  # DELETE /contents/1.json
  def destroy
    @content = User.find(params[:id])
    @content.destroy

    respond_to do |format|
      format.html { redirect_to admin_url }
      format.json { head :no_content }
    end
  end
  
  private
  
  def set_class
    @bodyclass = "admin admin-page"
  end
end