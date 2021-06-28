class Admin::EmprunteursController < ApplicationController
    def liste_en_attente
        @liste = liste_status(params, Utilisateur.status_en_attente)
    end 

    def liste_invalide
        @liste = liste_status(params, Utilisateur.status_invalide)
    end 

    def liste_valide
        @liste = liste_status(params, Utilisateur.status_active)
    end 

    def info    
        @user = Utilisateur.find_by(id: params[:id])
        if params[:btn].nil? || params[:btn].empty?
            @btn_validation_visible = true
        else
            puts "params[:btn]  => #{params[:btn]}"
            @btn_validation_visible = params[:btn].to_i > 0            
        end
    end

    def valider_compte
        validation params[:id], Utilisateur.status_active
    end

    def invalider_compte
        validation params[:id], Utilisateur.status_invalide
    end

private
    def validation (id, new_status)
        @user = Utilisateur.find_by(id: id)
        if @user.nil?
            errors = []; errors.push "Compte d'emprunteur inconnu"
            session[:errors] = errors
            redirect_to "/admin/liste_en_attente_emp"
            return
        end
        if @user.status.to_i == Utilisateur.status_active
            errors = []; errors.push "Compte d'emprunteur déjà activé"
            session[:errors] = errors
            redirect_to "/admin/liste_en_attente_emp"
            return
        end
        @user.status = new_status
        @user.save
        if new_status == Utilisateur.status_active
            #valider toutes les demandes en attente
            lst = Demande.where(:utilisateur_id => id)
            lst.each do |dmd|
                Demande.update(dmd.id, 
                    "date_accepted" => @user.updated_at, 
                    "status" => (dmd.status.to_i | 2**Demande.cond_status_compte)
                )
            end
        end
        redirect_to "/admin/liste_en_attente_emp"
    end

    def liste_status(les_params, le_status)
        start_date = les_params[:start_date]
        end_date = les_params[:end_date]
        phone = les_params[:phone]
        @liste = Utilisateur.where(status: le_status); nil  
        if start_date.nil? || start_date.empty?
        else
            @liste = @liste.where("created_at >= ?", [start_date]); nil
        end  
        if end_date.nil? || end_date.empty?
        else
            @liste = @liste.where("created_at <= ?", [end_date]); nil
        end  
        if phone.nil? || phone.empty?
        else
            @liste = @liste.where("phone LIKE ? ", "%#{sanitize_sql_like(phone)}%"); nil
        end  

        return @liste.all
    end
end
