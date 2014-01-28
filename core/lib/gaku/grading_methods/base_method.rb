module Gaku
  module GradingMethods
    class  BaseMethod
      attr_reader :exam, :students, :criteria, :results

      def initialize(exam, students, criteria = nil)
        @exam = exam
        @students = students
        @criteria = criteria
      end

      def grade
      end
    end
  end
end
