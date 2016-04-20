class Usuario < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  devise :omniauthable, omniauth_providers: [:facebook, :twitter]

	validates :username, presence: true, uniqueness: true
  

	#validate :validacion_personalizada, on: :create

  def self.find_or_create_by_omniauth(auth)
  	usuario = Usuario.where(provider: auth[:provider], uid: auth[:uid]).first

	  	unless usuario
	  		usuario = Usuario.create(
										  			nombre: auth[:nombre],
										  			apellido: auth[:apellido],
										  			username: auth[:username],
										  			email: auth[:email],
										  			uid: auth[:uid],
										  			provider: auth[:provider],
										  			password: Devise.friendly_token[0,20])
	  	end     	
  end 

  # private

  #    def validacion_personalizada
  #      if true

  #      else
  #        errors.add(:username, "Tu username no es valido")

  #      end
  #    end  
end
