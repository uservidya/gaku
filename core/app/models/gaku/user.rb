module Gaku
  class User < ActiveRecord::Base

    has_many :user_roles
    has_many :roles, through: :user_roles

    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :trackable, :validatable

    store :settings, accessors: [:locale]

    attr_accessor :login

    before_create :default_language

    validates :username, presence: true, uniqueness: true

    roles_table_name = Role.table_name

    scope :admin, -> { includes(:roles).where("#{roles_table_name}.name" => 'admin') }

    def to_s
      username
    end

    def self.find_first_by_auth_conditions(warden_conditions)
      conditions = warden_conditions.dup
      if login = conditions.delete(:login)
        where(conditions).where(['lower(username) = :value OR lower(email) = :value', { value: login.downcase }]).first
      else
        where(conditions).first
      end
    end

    def has_role?(role_sym)
      roles.any? { |r| r.name.underscore.to_sym == role_sym }
    end

    def role?(role)
      roles.detect {|p| p.name == role.to_s.camelize}
    end

    private

    def default_language
      if Preset.active.nil?
        settings[:locale] = 'en'
      else
        settings[:locale] = Preset.active.locale['language']
      end
    end

  end
end
