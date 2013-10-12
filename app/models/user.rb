class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  has_many :contacts
  has_many :accounting_records, :through => :contacts

  validates_presence_of :user_name
  validates_uniqueness_of :user_name
  validates_length_of :user_name, :minimum => 6, :maximum => 50

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.user_name = auth.info.nickname
      if auth.provider == "facebook"
        user.token = auth.credentials.token 
        user.email = auth.info.email
      end
    end
  end

  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"]) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end

  def password_required?
    super && provider.blank?
  end

  def active_records_count
    self.accounting_records.where("is_active IS TRUE").count
  end

  def passive_records_count
    self.accounting_records.where("is_active IS FALSE").count
  end

  def total_credit
    self.accounting_records.where("record_type = ?", :credit).sum("value")
  end

  def total_debt
    self.accounting_records.where("record_type = ?", :debt).sum("value")
  end

  def facebook
    FbGraph::User.me(self.token)
  end

end
