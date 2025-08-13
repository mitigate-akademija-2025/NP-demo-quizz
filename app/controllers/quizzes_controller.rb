class QuizzesController < ApplicationController
  before_action :authenticate_user!, except: [:public_show]
  before_action :set_quiz, only: %i[ show edit update destroy ]
  # skip user authentication for take action if you want guests to take quiz

  def public_show
    @quiz = Quiz.find_by!(share_token: params[:share_token])
    @questions = @quiz.questions.includes(:answers)
    @answer = Answer.new
  end

  def take
    @quiz = Quiz.find(params[:id])
    # show quiz questions to user here
  end

  def submit
    @quiz = Quiz.find(params[:id])
    # process answers from params and save a Response record
    # optionally associate with current_user if logged in
  end

  # GET /quizzes or /quizzes.json
  def index
    @quizzes = current_user.quizzes
  end

  # GET /quizzes/1 or /quizzes/1.json
  def show
  end

  # GET /quizzes/new
  def new
    @quiz = current_user.quizzes.build
    10.times do
      question = @quiz.questions.build
      question.answers.build
    end
  end

  # GET /quizzes/1/edit
  def edit
    (10 - @quiz.questions.size).times do
      question = @quiz.questions.build
      question.answers.build
    end
  end

  # POST /quizzes or /quizzes.json
  def create
    # Quiz.new(quiz_params)
    @quiz = current_user.quizzes.build(quiz_params)
    if @quiz.save
      redirect_to @quiz, notice: "Quiz was successfully created."
    else
      render :new
    end

    # respond_to do |format|
    #   if @quiz.save
    #     format.html { redirect_to @quiz, notice: "Quiz was successfully created." }
    #     format.json { render :show, status: :created, location: @quiz }
    #   else
    #       format.html { render :new, status: :unprocessable_entity }
    #       format.json { render json: @quiz.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /quizzes/1 or /quizzes/1.json
  def update
    # if @quiz.update(quiz_params)
    #   redirect_to @quiz, notice: 'Quiz was successfully updated.'
    # else
    #   render :edit
    # end

    respond_to do |format|
      if @quiz.update(quiz_params)
        format.html { redirect_to @quiz, notice: "Quiz was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @quiz }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @quiz.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /quizzes/1 or /quizzes/1.json
  def destroy
    @quiz.destroy!

    respond_to do |format|
      format.html { redirect_to quizzes_path, notice: "Quiz was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_quiz
      @quiz = current_user.quizzes.find(params[:id])
      # Quiz.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def quiz_params
      # params.expect(quiz: [ :title, :description ])
      params.require(:quiz).permit(
        :title, :description,
        questions_attributes: [
        :id, :name, :_destroy,
        answers_attributes: [:id, :content, :_destroy]
        ]
      )
    end
end
