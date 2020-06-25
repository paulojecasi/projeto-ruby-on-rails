#class AdminsBackoffice::AdminsController < ApplicationController
class AdminsBackoffice::AdminsController < AdminsBackofficeController

    before_action :verificaSenhaEmBranco, only: [:update]
    before_action :set_admin_find_jecasi, only: [:edit, :update, :destroy]


    def index
        #@admins = Admin.all 
        #-- foi adicionado o "page params[:page]" para pagina a lista de adm- PJCS 
        @admins = Admin.all.page(params[:page])
        #-- pra commpletar a paginação, tem que colocar o "<%= paginate @admins %>"  no:
        #-- app\views\admins_backoffice\admins\index.html.erb
        # pra controlar o qtd de itens por pagina, vamos no: app\models\admin.rb
    end

    def new
        @admin = Admin.new 
    end 

    def create
        @admin = Admin.new(params_admin)
        if @admin.save()
            # As informações vinheram do: app\views\admins_backoffice\admins\new.html.erb
            # se for TRUE, vamos voltar para tela principal do ADMIN - PJCS
            redirect_to admins_backoffice_admins_path, notice: "Administrador cadastrado com sucesso!"
        else 
            # se for FALSE, volta pra a EDIÇÃO - PJCS 
            render :edit 
        end
    
    end 

    def edit
        #  o ID veio do: app\views\admins_backoffice\admins\index.html.erb - PJCS 
        # @admin= Admin.find(params[:id]) -> passou a ser chamado no BEFORE_ACTION - PJCS
    end 

    def update
        # o ID veio do: app\views\admins_backoffice\admins\edit.html.erb - PJCS 
        # @admin = Admin.find(params[:id]) -> passou a ser chamado no BEFORE_ACTION - PJCS
        if @admin.update(params_admin)
            # se for TRUE, vamos voltar para tela principal do ADMIN - PJCS
            redirect_to admins_backoffice_admins_path, notice: "Administrador atualizado com sucesso!"
        else 
            # se for FALSE, volta pra a EDIÇÃO - PJCS 
            render :edit 
        end
    end

    def destroy
        # o ID veio do: app\views\admins_backoffice\admins\index.html.erb - PJCS 
        # @admin = Admin.find(params[:id]) -> passou a ser chamado no BEFORE_ACTION - PJCS
        if @admin.destroy
            # se for TRUE, vamos voltar para tela principal do ADMIN - PJCS
            redirect_to admins_backoffice_admins_path, notice: "Administrador excluido com sucesso!"
        else 
            # se for FALSE, volta pra a EDIÇÃO - PJCS 
            render :index
        end

    end 

    private

    def verificaSenhaEmBranco 
        if params[:admin][:password].blank? && params[:admin][:password_confirmation].blank?
            params[:admin].extract!(:password, :password_confirmation)
        end 
    end

    def params_admin
         # PJCS -  vamos autorizar  o UPDATE dos dados abaixo
         params_admin = params.require(:admin).permit(:email, :password, :password_confirmation)
    end 

    def set_admin_find_jecasi  
        #  o ID veio do: app\views\admins_backoffice\admins\index.html.erb - PJCS 
        @admin= Admin.find(params[:id])
    end 
end
