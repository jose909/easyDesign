class Usuario < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  devise :omniauthable, omniauth_providers: [:facebook, :twitter]

  def costo_compra_pendiente
    payments.where(estado: 1).joins("INNER JOIN posts on posts.id == payments.post_id").sum("costo")
  end
  validates :username, presence: true, uniqueness: true

  has_many :posts
  has_many :friendships, foreign_key: "usuario_id", dependent: :destroy
  has_many :follows, through: :friendships, source: :friend
  has_many :followers_friendships, class_name: "Friendship", foreign_key: "friend_id"
  has_many :followers, through: :followers_friendships, source: :usuario
  has_many :payments
 

  def follow!(amigo_id)  # Modifica
    friendships.create!(friend_id: amigo_id)
  end

  # No puede seguirse a uno mismo o que ya exista la relación (devuelve mayor de 0)
  def can_follow?(amigo_id)
    not amigo_id == self.id or friendships.where(friend_id: amigo_id).size > 0
  end


  def email_required?
    false
  end

  def self.find_or_create_by_omniauth(auth)
    usuario = Usuario.where(provider: auth[:provider], uid: auth[:uid]).first

    # Si no existe el usuario en la bd lo crea
    unless usuario
      usuario = Usuario.create(
        nombre: auth[:nombre],
        apellido: auth[:apellido],
        username: auth[:username],
        email: auth[:email],
        provider: auth[:provider],
        uid: auth[:uid],
        password: Devise.friendly_token[0,20]
        )
    end
    usuario
  end

  private

    # def validacion_personalizada
    #   if true

    #   else
    #     errors.add(:username, "Tu username no es valido")

    #   end
    # end

end