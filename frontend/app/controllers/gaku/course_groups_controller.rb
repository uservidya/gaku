module Gaku
  class CourseGroupsController < GakuController

    helper_method :sort_column, :sort_direction

    # respond_to :js,   only: %i( new create edit update destroy recovery )
    # respond_to :html, only: %i( index edit update soft_delete )
    respond_to :html, :js

    before_action :set_course_group,          only: %i( edit show update destroy )
    before_action :set_courses

    def destroy
      @course_group.destroy
      set_count
      respond_with @course_group
    end

    def new
      @course_group = CourseGroup.new
      respond_with @course_group
    end

    def create
      @course_group = CourseGroup.new(course_group_params)
      @course_group.save
      set_count
      respond_with @course_group
    end

    def edit
      @course_group_enrollment = CourseGroupEnrollment.new
    end

    def update
      @course_group.update(course_group_params)
      respond_with(@course_group) do |format|
        format.js { render }
        format.html { redirect_to [:edit, @course_group] }
      end
    end

    def index
      @course_groups = CourseGroup.order(sort_column + ' ' + sort_direction)
      set_count
      respond_with @course_groups
    end

    private

    def course_group_params
      params.require(:course_group).permit(attributes)
    end

    def attributes
      %i( name code )
    end

    def set_course_group
      @course_group = CourseGroup.find(params[:id])
      set_notable
    end


    def set_courses
      @courses = Course.all
    end

    def t_resource
      t(:'course_group.singular')
    end

    def set_notable
      @notable = @course_group
      @notable_resource = get_resource_name @notable
    end

    def set_count
      @count = CourseGroup.count
    end

    def sort_column
      ClassGroup.column_names.include?(params[:sort]) ? params[:sort] : 'name'
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
    end

  end
end
