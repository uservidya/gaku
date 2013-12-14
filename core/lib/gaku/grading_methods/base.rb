module Gaku
  module GradingMethods
    class  Base

      def initialize(method, exam, students)
        raise 'NoGradingMethodFound' unless method == :score
        case method
        when :score
          @method = Gaku::GradingMethods::Score.new(exam, students)
        end
      end

      #caluclation
      def grade

      end

      #find based on key
      def get_grade(key)
        @method.get_grade(key)
      end

    end
  end
end
