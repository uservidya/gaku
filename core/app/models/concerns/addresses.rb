module Addresses
  extend ActiveSupport::Concern

  included do
    has_many :addresses, as: :addressable

    def get_primary_address
      addresses.where(primary: true).first
    end

    def address_widget
      if get_primary_address
        "#{get_primary_address.city}, " + "#{get_primary_address.address1}"
      end
    end
  end
end
