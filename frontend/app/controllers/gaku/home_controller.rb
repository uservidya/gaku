module Gaku
  class HomeController < GakuController
    layout 'gaku/layouts/home'

    skip_authorization_check

    before_filter :_reload_libs

    def index
      @results = Gaku::GradingMethods::Base.new(:score, 1, ['georgi', 'vassil', 'rei'])
      # raise result.inspect
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
