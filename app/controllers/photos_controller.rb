class PhotosController < ApplicationController
  
  def create
    @photo = Photo.new(params[:photo])
    @photo.session_token = params[:session_token]
    if @photo.save
      render :text => @photo.cover_picture.url(:thumb)
    else
      render :text => '<p id="output">fuckoff</p>'
    end
  end

  #FIXME: security: see aul implementation
  def destroy
    picture = Picture.find(params[:id])
    picture.destroy
    render :text => 'picture destroyed'
  end

end
