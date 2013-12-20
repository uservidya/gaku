module GradingMethodsLookup

  extend ActiveSupport::Concern

  included do

    private

    def grading_method(method)
      raise 'NoGradingMethodFound' unless grading_methods.include?(method)
      grading_methods[method]
    end

    def grading_methods
      ActiveSupport::HashWithIndifferentAccess.new({
        score: Gaku::GradingMethods::Score
      })
    end


  end
end
