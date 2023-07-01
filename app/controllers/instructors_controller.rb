class InstructorsController < ApplicationController
    def index
        render json: Instructor.all
    end

    def show
        instructor = find_instructor
        render json: instructor
    end

    def create
        new_instructor = Instructor.create!(instructor_params)
        render json: new_instructor, status: :created
    end

    def update
        instructor = find_instructor
        instructor.update!(instructor_params)
        render json: instructor, status: :ok
    end

    def destroy
        instructor = find_instructor
        instructor.destroy
        render json: { message: "Instructor Deleted" }, status: :ok
    end


    private

    def find_instructor
        Instructor.find(params[:id])
    end

    def instructor_params
        params.permit(:name)
    end

    def render_not_found_response
        render json: { errors: "Records not found"}, status: :not_found
    end

    def render_unprocessable_entity_response(invalid)
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end

end
