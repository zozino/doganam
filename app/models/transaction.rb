class Transaction < ApplicationRecord
    TAUX_ENT = 0.03
    TAUX_SORT = 0

    TAUX_PRET = 0.33

    #Recherche des transactions Paygate par tx_reference, 
    #par payment_reference, dans une période donnée, 
    #par sender_phone, par receiver_phone
    def self.transactions(the_params)
        dt_deb_s = the_params[:dt_deb_s]
        dt_fin_s = the_params[:dt_fin_s]
        dt_deb_r = the_params[:dt_deb_r]
        dt_fin_r = the_params[:dt_fin_r]
        sender_phone = the_params[:sender_phone]
        receiver_phone = the_params[:receiver_phone]
        tx_reference = the_params[:tx_reference]
        payment_reference = the_params[:payment_reference]
        is_envoi = the_params[:is_envoi]
        cond_arr = []
        
        if !(dt_deb_s.nil? || dt_deb_s.empty?)
            cond_arr.push ["date_sent >= ?", dt_deb_s]
        end
        if !(dt_fin_s.nil? || dt_fin_s.empty?)
            cond_arr.push ["date_sent <= ?", dt_fin_s]
        end        
        if !(dt_deb_r.nil? || dt_deb_r.empty?)
            cond_arr.push ["date_received >= ?", dt_deb_r]
        end
        if !(dt_fin_r.nil? || dt_fin_r.empty?)
            cond_arr.push ["date_received <= ?", dt_fin_r]
        end
        if !(sender_phone.nil? || sender_phone.empty?)
            cond_arr.push ["sender_phone LIKE ?", "%" + sender_phone + "%"]
        end
        if !(receiver_phone.nil? || receiver_phone.empty?)
            cond_arr.push ["receiver_phone LIKE ?", "%" + receiver_phone + "%"]
        end
        if !(tx_reference.nil? || tx_reference.empty?)
            cond_arr.push ["tx_reference LIKE ?", "%" + tx_reference + "%"]
        end
        if !(payment_reference.nil? || payment_reference.empty?)
            cond_arr.push ["payment_reference LIKE ?", "%" + payment_reference + "%"]
        end
        if !(is_envoi.nil? || is_envoi.empty?)
            if is_envoi
                cond_arr.push ["is_envoi = ?", 1]
            else
                cond_arr.push ["is_envoi = ?", 0]
            end
        end

        tout = Transaction 
        .joins(" INNER JOIN Demandes D ON (Transactions.demande_id = D.id)")
        .select ("Transactions.*, D.amount_borrowed AS amount_borrowed, 
            D.amount_to_repay AS amount_to_repay, D.taux AS taux")
        
                
        cond_arr.each do |one_cond|
            tout.where!(one_cond)
        end

        return tout
    end

    #Journal d'entrée et de sortie d'argent dans 
    # une période donnée sur le compte Paygate 
    # de Doganam
    def self.revenus_paygate(the_params)
        #Là, les montants intervenant dans les transactions Paygate de remboursement de prêt
        #* montant prélevé par Paygate à l'entrée comme sortie
        #* montant prélevé par Paygate à l'envoi de l'argent par Flooz à l'emprunteur comme sortie
        #* montant envoyé à l'emprunteur

        liste_trans = transactions(the_params)
        @liste = []
        liste_trans.each do |ligne|
            if !ligne.is_envoi
                mont_preteur = (ligne.amount_borrowed * (1 + ligne.taux * TAUX_PRET)).floor
                #* montant payé à Paygate comme entrée
                if 1 == 1
                    c = {}
                    c["desc"] = "Montant envoyé à Paygate"
                    c["date"] = ligne.date_received
                    c["entree"] = ligne.amount 
                    c["sortie"] = 0
                    @liste.push(c)                   
                end
                #* montant prélevé par Paygate à l'entrée comme sortie
                if 1 == 1
                    c = {}
                    c["desc"] = "Frais d'envoi à Paygate"
                    c["date"] = ligne.date_received
                    c["entree"] = 0
                    c["sortie"] = (ligne.amount * TAUX_ENT).ceil
                    @liste.push(c)         
                end
                #* montant prélevé par Paygate à l'envoi de l'argent 
                # par Flooz à l'emprunteur comme sortie
                if 1 == 1
                    c = {}
                    c["desc"] = "Frais de reversement, Paygate"
                    c["date"] = ligne.date_received
                    c["entree"] = 0
                    c["sortie"] = (mont_preteur * TAUX_SORT).ceil
                    @liste.push(c)       
                end
                #* montant envoyé au client (emprunteur ou prêteur)
                if 1 == 1
                    c = {}
                    c["desc"] = "Reversement Paygate"
                    c["date"] = ligne.date_received
                    c["entree"] = 0
                    c["sortie"] = mont_preteur
                    @liste.push(c)
                end

            end
        end

        return @liste
    end

end
