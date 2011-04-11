class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug
  include Mongoid::Paperclip

  field :login
  field :name
  slug  :login
  field :roles_mask, :type => Fixnum, :default => 0
  field :phone

  references_many :lots, :dependent => :delete
  referenced_in   :company

  validates_presence_of   :login, :email
  validates_uniqueness_of :login, :email, :case_sensitive => false

  attr_accessible :name, :login, :phone, :email, :password, 
                                 :password_confirmation, 
                                 :remember_me, :roles_mask, :avatar

  has_mongoid_attached_file :avatar,
                            :styles => { 
                              :popup  => "800x600=",
                              :medium => "300x300>",
                              :thumb  => "100x100>",
                              :icon   => "64x64"
                            }

  # Roles - Do not change the order and do not remove roles if you
  # already have productive data! Thou it's safe to append new roles
  # at the end of the string. And it's safe to rename roles in place
  ROLES = [:guest, :confirmed_user, :moderator, :maintainer, :admin]
  scope :with_role, lambda { |role| { :where => {:roles_mask.gte => ROLES.index(role) } } }

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, 
  # :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def admin?
    User.all.any? ? (self == User.first || role?(:admin)) : true
  end

  def role=(role)
    self.roles_mask = ROLES.index(role)
    Rails.logger.warn("SET ROLES TO #{self.roles_mask} FOR #{self.inspect}")
  end
  
  # return user's role as symbol.
  def role
    ROLES[roles_mask].to_sym
  end

  # Ask if the user has at least a specific role.
  # @user.role?('admin')
  def role?(role)
    self.roles_mask >= ROLES.index(role.to_sym)
  end

  # remove the password and password-confirmation attribute if not needed.
  def update_with_password(params={})
    if params[:password].blank?
      params.delete(:password)
      params.delete(:password_confirmation) if params[:password_confirmation].blank?
    end
    super
  end
end

