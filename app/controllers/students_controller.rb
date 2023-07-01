class StudentsController < ApplicationController
    def index
        render json: Student.all
    end

    def show
        student = find_student
        render json: student
    end

    def create
        new_student = Student.create!(student_params)
        render json: new_student, status: :created
    end

    def update
        student = find_student
        student.update!(student_params)
        render json: student, status: :ok
    end

    def destroy
        student = find_student
        student.destroy
        render json: { message: 'Student was successfully deleted' }, status: :ok
    end


    private

    def find_student
        Student.find(params[:id])
    end

    def student_params
        params.permit(:name, :major, :age, :instructor_id)
    end

    def render_not_found_response
        render json: { errors: "Student records not found"}, status: :not_found
    end

    def render_unprocessable_entity_response(invalid)
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end

end
