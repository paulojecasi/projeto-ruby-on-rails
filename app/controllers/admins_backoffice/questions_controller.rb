class AdminsBackoffice::QuestionsController < AdminsBackofficeController

    before_action :set_question_find_jecasi, only: [:edit, :update, :destroy]

    before_action :get_subjects_jecasi, only: [:edit, :new]

    
    def index
        @questions = Question.includes(:subject).order(:description).page(params[:page])
    end

    def new
        @question = Question.new 
    end 

    def create
        @question = Question.new(params_question)
        if @question.save()
            redirect_to admins_backoffice_questions_path, notice: "Questão cadastrado com sucesso!"
        else
            render :edit 
        end
    
    end 

    def edit 
    end 

    def update

        if @question.update(params_question)
            redirect_to admins_backoffice_questions_path, notice: "Questão atualizado com sucesso!"
        else 
            render :edit 
        end
    end

    def destroy
        if @question.destroy
            # se for TRUE, vamos voltar para tela principal do ADMIN - PJCS
            redirect_to admins_backoffice_questions_path, notice: "Questão excluido com sucesso!"
        else 
            # se for FALSE, volta pra a EDIÇÃO - PJCS 
            render :index
        end

    end 

    private


    def params_question
         # PJCS -  vamos autorizar  o UPDATE dos dados abaixo
         params_question = params.require(:question).permit(:description, :subject_id, 
                         answers_attributes: [:id, :description, :correct, :_destroy]))
         
    end 

    def set_question_find_jecasi  
        #  o ID veio do: app\views\admins_backoffice\admins\index.html.erb - PJCS 
        @question= Question.find(params[:id])
    end 

    def get_subjects_jecasi
        @subjects= Subject.all
    end
end 