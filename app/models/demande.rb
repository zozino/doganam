class Demande < ApplicationRecord
    
###################################################
    def self.cond_status_compte
        0
    end
    def self.cond_status_expire
        1
    end
    def self.cond_status_accepte
        2
    end
    def self.cond_status_delai
        3
    end
    def self.cond_status_paye
        4
    end
###################################################
    def self.status_cpt_non_valide_expire
        0b00000
    end
    def self.status_cpt_valide_expire
        0b00001
    end
    def self.status_cpt_non_valide_nonexpire
        0b00010
    end
    def self.status_en_attente_pret
        0b00011
    end
    def self.status_nonpaye_apr_delai
        0b00111
    end
    def self.status_nonpaye_avt_delai
        0b01111
    end
    def self.status_paye_apr_delai
        0b10111
    end
    def self.status_paye_avt_delai
        0b11111
    end

    def self.all_status
        {
            status_cpt_non_valide_expire => "Demande expirée d'un compte non valide",
            status_cpt_valide_expire => "Demande expirée d'un compte validé",
            status_cpt_non_valide_nonexpire => "Demande non expirée d'un compte non valide",
            status_en_attente_pret => "Demande en attente de validation",
            status_nonpaye_apr_delai => "Prêt non remboursé, délai dépassé",
            status_nonpaye_avt_delai => "Prêt accordé, non remboursé en règle",
            status_paye_apr_delai => "Prêt remboursé, délai dépassé",
            status_paye_avt_delai => "Prêt remboursé dans le délai"
        }
    end
###################################################
###################################################
###################################################
    #En cours ::::::  A FAIRE plus tard
    #def self.conditions_from_status(the_status, la_date)
    #    cond_arr = []
    #    s = 1
    #    for x in 0..4 do
    #        if s == the_status & s
    #            case x
    #            when cond_status_compte
    #                cond_arr.push ["Utilisateurs.status = ?", Utilisateurs.status_active]
    #            when cond_status_expire
    #                cond_arr.push ["Demandes.date_accepted is null", nil]
    #                #   pour
    #                    if Rails.env.production?
    #                #   cond_arr.push ["Demandes.created_at + Demandes.nombre_de_jour < ?", la_date]
    #                    else if Rails.env.development?
                            #   cond_arr.push ["Demandes.created_at + Demandes.nombre_de_jour < ?", la_date]
    #                    end
    #            when cond_status_accepte
    #                cond_arr.push ["Demandes.date_accepted is not null", nil]
    #            when cond_status_delai
    #                cond_arr.push ["Demandes.date_accepted + Demandes.nombre_de_jour > Demandes. is not null", nil]
    #            when cond_status_paye
    #            "The tank is almost full."
    #            end    
    #        end    
    #        s *= 2    
    #    end

    #end
#{"dt_deb" => "2020-01-01", "dt_fin" => "2022-01-01" }
    def self.cond_demandes(the_params)
        dt_deb = the_params["dt_deb"]
        dt_fin = the_params["dt_fin"]
        num_phone = the_params["phone"]
        quartier = the_params["quartier"]
        cond_arr = [] 
        
        if !(dt_deb.nil? || dt_deb.empty?)
            cond_arr.push ["Demandes.created_at >= ?", dt_deb]
            puts "dt_deb = #{dt_deb}"
        end
        if !(dt_fin.nil? || dt_fin.empty?)
            cond_arr.push ["Demandes.created_at <= ?", dt_fin]
            puts "dt_fin = #{dt_fin}"
        end
        if !(num_phone.nil? || num_phone.empty?)
            cond_arr.push ["lender_phone LIKE ?",  "%#{num_phone}%"]
            puts "num_phone = #{num_phone}"
        end
        if !(quartier.nil? || quartier.empty?)
            cond_arr.push ["U.quartier LIKE ?", "%#{quartier}%"]
            puts "quartier = #{quartier}"
        end
        
        return cond_arr
    end

    #Liste des demandes par Emprunteur, 
    #dans une période donné, selon leurs états 
    #(créées par des comptes non validés, 
    #    en attente pour prêt, 
    #    prêt accepté, remboursé, 
    #    non remboursé)
    def self.demandes(the_params)
        cond_arr = cond_demandes(the_params)

        tout = Demande
        .joins("INNER JOIN Utilisateurs U ON Demandes.utilisateur_id = U.id")
        .select("U.*, Demandes.*")

        cond_arr.each do |one_cond|
            tout.where!(one_cond)
        end

        return tout
    end

    #Liste des demandes par Emprunteur, 
    #dans une période donné, selon leurs états 
    #(créées par des comptes non validés, 
    #    en attente pour prêt, 
    #    prêt accepté, remboursé, 
    #    non remboursé)
    def self.nombre_demandes(the_params)
        cond_arr = cond_demandes(the_params)

        tout = Demande
        .select("Demandes.status, COUNT(*) as nombre")

        cond_arr.each do |one_cond|
            tout.where!(one_cond)
        end

        tout.group!("Demandes.status")
        tout.order!("Demandes.status")

        return tout
    end

    #Regroupement par quartier, montant prêté, montant remboursé
    def self.montant_prete(the_params)
        dt_deb = the_params[:dt_deb]
        dt_fin = the_params[:dt_fin]
        cond_arr = []
        
        if !(dt_deb.nil? || dt_deb.empty?)
            cond_arr.push ["date_disbursed >= ?", dt_deb]
        end
        if !(dt_fin.nil? || dt_fin.empty?)
            cond_arr.push ["date_disbursed <= ?", dt_fin]
        end        
        
        
        tout = Demande 
        .joins(" INNER JOIN Utilisateurs U ON (U.id = Demandes.utilisateur_id)")
        .select ("quartier, 
            SUM(amount_borrowed) AS mont_pret, 
            SUM(amount_to_repay) AS mont_a_payer, 
            SUM(amount_total_paid) AS mont_remb")
        
        cond_arr.each do |one_cond|
            tout.where!(one_cond)
        end
        tout.group("quartier") ;

        return tout
    end

    def self.montant_rembourse(the_params)
        dt_deb = the_params[:dt_deb]
        dt_fin = the_params[:dt_fin]
        cond_arr = []
        
        if !(dt_deb.nil? || dt_deb.empty?)
            cond_arr.push ["date_repaid >= ?", dt_deb]
        end
        if !(dt_fin.nil? || dt_fin.empty?)
            cond_arr.push ["date_repaid <= ?", dt_fin]
        end        
        
        
        tout = Demande 
        .joins(" INNER JOIN Utilisateurs U ON (U.id = Demandes.utilisateur_id)")
        .select ("quartier,  
            SUM(amount_total_paid) AS mont_remb")
        
        cond_arr.each do |one_cond|
            tout.where!(one_cond)
        end
        tout.group("quartier") ;

        return tout
    end

    def self.nombre_quartier(the_params)
        dt_deb = the_params[:dt_deb]
        dt_fin = the_params[:dt_fin]
        cond_arr = []
        
        if !(dt_deb.nil? || dt_deb.empty?)
            cond_arr.push ["created_at >= ?", dt_deb]
        end
        if !(dt_fin.nil? || dt_fin.empty?)
            cond_arr.push ["created_at <= ?", dt_fin]
        end        
        
        
        tout = Demande
        .joins(" INNER JOIN Utilisateurs U ON (U.id = Demandes.utilisateur_id)")
        .select ("count(DISTINCT quartier) as nbre")
        
        cond_arr.each do |one_cond|
            tout.where!(one_cond)
        end

        return tout.length > 0 ? tout[0]["nbre"] : 0;      
    end
end
