class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,:validatable

  before_create :set_permission_level #usuarios por defecto

  has_many :articles, dependent: :delete_all
  has_many :comments, dependent: :delete_all

include PermissionsConcern

def avatar
  email_address = self.email.downcase
 
  # create the md5 hash
  hash = Digest::MD5.hexdigest(email_address)
  
  # compile URL which can be used in <img src="RIGHT_HERE"...
  image_src = "https://www.gravatar.com/avatar/#{hash}"
end

private

  def set_permission_level
    self.permission_level = 1 #Si le hubiese puesto create era sin el ||, pero como puse el save
    #es para cuando no esté creado el visits_count así el || es... si es nulo, dale 0, sino nada
    #! Este paso también se pudo haber hecho en la migración con un default, pero esto lo había hecho antes de saberlo.

  end


end
