module AdminsBackofficeHelper
    def translate_attribute(object=nil ,method=nil)
        if object && method
            #PJCS  vai pegar o "method" no:config\locales\models.pt-BR.yml
            object.model.human_attribute_name(method)
        else 
            "Informe os Parametros Corretamente!"
        end
    end
end
