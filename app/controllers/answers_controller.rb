class AnswersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:public_create]

  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.build(answer_params)
    @answer.user = current_user if user_signed_in?

    if @answer.save
      redirect_back fallback_location: root_path, notice: "Your answer has been recorded."
    else
      redirect_back fallback_location: root_path, alert: "There was a problem saving your answer."
    end
  end

  # GET /answers or /answers.json
  def index
    @answers = Answer.all
  end

  # GET /answers/1 or /answers/1.json
  def show
  end

  # GET /answers/new
  def new
    @answer = Answer.new
  end

  # GET /answers/1/edit
  def edit
  end

  # POST /answers or /answers.json
  def create
    @answer = Answer.new(answer_params)

    respond_to do |format|
      if @answer.save
        format.html { redirect_to @answer, notice: "Answer was successfully created." }
        format.json { render :show, status: :created, location: @answer }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  def public_create
    @quiz = Quiz.find_by!(share_token: params[:share_token])
    
    params[:answers].each do |answer_param|
      next if answer_param[:content].blank? # skip empty answers
      Answer.create(
        question_id: answer_param[:question_id],
        content: answer_param[:content]
        # optional: add user_id if needed for logged-in users
      )
    end
    flash[:notice] = "Your answers were successfully submitted!"
    redirect_to public_quiz_path(@quiz.share_token)
  end

  # PATCH/PUT /answers/1 or /answers/1.json
  def update
    respond_to do |format|
      if @answer.update(answer_params)
        format.html { redirect_to @answer, notice: "Answer was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @answer }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /answers/1 or /answers/1.json
  def destroy
    @answer.destroy!

    respond_to do |format|
      format.html { redirect_to answers_path, notice: "Answer was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_answer
      @answer = Answer.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def answer_params
      params.require(:answer).permit(:content)
    end
end
