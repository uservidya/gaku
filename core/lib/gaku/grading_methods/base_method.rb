module Gaku
  module GradingMethods
    class  BaseMethod

      attr_reader :exam, :students, :parameters, :results

      def initialize(exam, students, parameters = nil)
        @exam = exam
        @students = students
        @parameters = parameters
      end

      def grade
      end

    end
  end
end
