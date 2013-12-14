module Gaku
  module GradingMethods
    class  Score

      def initialize(exam, students)
        @exam = exam
        @students = students
      end

      def grade
        [@exam, @students]
      end

      def get_grade(key)
        @students[key]
      end

    end
  end
end
