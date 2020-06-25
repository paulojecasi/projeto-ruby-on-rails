class AdminsBackoffice::SubjectsController < AdminsBackofficeController

    before_action :set_subject_find_jecasi, only: [:edit, :update, :destroy]


    def index
        @subjects = Subject.all.order(:description).page(params[:page])
    end

    def new
        @subject = Subject.new 
    end 

    def create
        @subject = Subject.new(params_subject)
        if @subject.save()
            redirect_to admins_backoffice_subjects_path, notice: "Areas/Assuntos cadastrado com sucesso!"
        else
            render :edit 
        end
    
    end 

    def edit

    end 

    def update

        if @subject.update(params_subject)
            redirect_to admins_backoffice_subjects_path, notice: "Areas/Assuntos atualizado com sucesso!"
        else 
            render :edit 
        end
    end

    def destroy
        if @subject.destroy
            # se for TRUE, vamos voltar para tela principal do ADMIN - PJCS
            redirect_to admins_backoffice_subjects_path, notice: "Areas/Assuntos excluido com sucesso!"
        else 
            # se for FALSE, volta pra a EDIÇÃO - PJCS 
            render :index
        end

    end 

    private


    def params_subject
         # PJCS -  vamos autorizar  o UPDATE dos dados abaixo
         params_subject = params.require(:subject).permit(:description)
    end 

    def set_subject_find_jecasi  
        #  o ID veio do: app\views\admins_backoffice\admins\index.html.erb - PJCS 
        @subject= Subject.find(params[:id])
    end 
end