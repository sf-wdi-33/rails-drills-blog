class User < ActiveRecord::Base

  has_secure_password

  # validations
  validates :email, presence: true, uniqueness: true, confirmation: true
  # email_confirmation is a virtual field added when confirmation: true
  # is set on the email attribute.  if nil the confirmation won't be done,
  # so validate its presence
  validates :email_confirmation, presence: true

  # associations
  has_many :articles

  # returns @user or false
  def self.confirm params
    user = User.find_by(email: params[:email])
    user.try(:authenticate, params[:password])
  end

end

