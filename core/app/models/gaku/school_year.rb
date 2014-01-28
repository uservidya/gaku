module Gaku
  class SchoolYear < ActiveRecord::Base
    has_many :semesters

    validates :starting, :ending, presence: true

    validate :ending_after_starting

    private

    def ending_after_starting
      return if  starting.blank? && ending.blank?
      if starting >= ending
        errors.add(:base, I18n.t(:'school_year.ending_after_starting'))
      end
    end
  end
end
