class Photo 
  include Mongoid::Document
  include Mongoid::Paperclip

  field :session_token
  referenced_in :lot

  has_mongoid_attached_file :cover_picture,
                            :styles => { 
                              :medium => "560X380>",
                              :thumb  => "84X64>"
                            }
  def cover_picture_exists?
    cover_picture && !cover_picture.original_filename.blank?
  end
end
