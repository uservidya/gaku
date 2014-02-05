module Gaku
  class HomeController < GakuController
    include GradingMethodsLookup
    layout 'gaku/layouts/home'

    skip_authorization_check

    before_action :_reload_libs if Rails.env.development?

    def index
      if Rails.env.development?
        @exam = Gaku::Exam.find(25)
        @students = Gaku::Course.find(5).students
        @results = grading_method(:score).new(@exam, @students)
      end
      redirect_to new_user_session_path unless user_signed_in?
    end


    def _reload_libs
      libs.each do |lib|
        require_dependency lib
      end
    end

    def libs
      Dir[Gaku::Core::Engine.root + 'lib/gaku/grading_methods/*.rb'] if Rails.env.development?
    end
  end
end
