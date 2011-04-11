# _*_ coding: utf-8 _*_
class UsersController < ApplicationController
  #FIXME: load_and authorize resource due to security
  before_filter :authenticate_user!

  def show
    @user = User.find_by_slug(params[:id])
  end

  def edit
    @user = User.find_by_slug(params[:id])
  end

  def destroy
    @user.delete
    redirect_to registrations_path,
      :notice => 'Пользователь удален'
  end

end
