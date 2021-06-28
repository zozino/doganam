require 'uri'
require 'net/http'
require 'json'

class PaygateController < ApplicationController

    def self.sms_alert(from, to, text)
        data =  {
            "from" => from,
            "to" => "+228#{to}",
            "content" => text
        }
        puts data.to_json
        uri = URI.parse("https://smapi.azlabs.dev/api/messages")
        request = Net::HTTP::Post.new(uri)
        request.content_type = "application/json"
        request["Authorization"] = "ACCESS_TOKEN zAUm8fM2B7g.qI2OM5PjtHTCn625.xKgkY4.WAO3MO6tQ7itQx3oK65l5mc8aFZWKJWbvSDU8Te.TOfv1FtBCeaLRe1LO6r5Gr2pXO0yFjeY7Eu5IuDHxTdb6nGmg2joQzAY5cP5qdt5juU8mEHkereWblh2zAdKR6HvtBZtkK3cX52uiH.xSPuto69fZtaMmWyENIRC..Kywwe364y7tB2VawNIF1yBpsVASMMPyHpYopBDuRNZmkdj3eVsyNB6tNnN.5XaJq2rocuE7C54OdbfshXhL6JzyXJ5r2P16eYPSGH4ZSy5499ablOIgjB5mmbPU7C7qHMcEIlEs6a0Mg"
        request["X-CLIENT-ID"] = "8D25B20F-0416-42DC-A60C-A0659A012D7F"
        request.body = data.to_json

        req_options = {
          use_ssl: uri.scheme == "https",
        }
        
        response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
          http.request(request)
        end

        puts response.value
    end

    def paygateaccepterpret
        #Enregistrement la transaction
        d = Demande.find_by(id: params[:id_demande])
        t = Transaction.new
        t.sender_phone = params[:phone]
        t.receiver_phone = d.phone
        t.amount = params[:amount]
        t.is_envoi = true
        t.demande_id = d.id
        if ! t.save
            @message = "Enregistrement de l'opération en cours échoué"
            redirect_to :back
        end
        
        # appel de l'API PaygateGlobal
        # pour lancer la demande de paiement
        # du prêteur

        pg_success = true #provisoire
        if ! pg_success 
            @message = "La paiement a échoué"
            redirect_to :back            
        end

        #provisoirement
        #apres, ces lignes de code vont disparaître
        finalisation_transaction(t.id, "#{rand 100..1000}", "#{rand 100..1000}")

        
        @message = ""
        redirect_to "/listedemandepret"           
    end
    
    def paygaterembourser    
        #Enregistrement la transaction
        d = Demande.find_by(id: params[:id_demande])
        t = Transaction.new
        t.sender_phone = params[:phone]
        t.receiver_phone = d.phone
        t.amount = params[:amount]
        t.is_envoi = false
        t.demande_id = d.id
        if ! t.save
            redirect_to :back
        end 
        
        # appel de l'API PaygateGlobal
        # pour lancer la demande de paiement
        # du demandeur

        pg_success = true #provisoire
        if ! pg_success 
            redirect_to :back            
        end

        #provisoirement
        #apres, ces lignes de code vont disparaître
        finalisation_transaction(t.id, "#{rand 100..1000}", "#{rand 100..1000}")
        
        @message = ""
        redirect_to "/evolutiondemande"          
    end

    #tx_reference
    #identifier
    #payment_reference
    #amount
    #datetime
    #payment_method
    #phone_number
    def callback

    end

    private
    def envoi_argent(id_trans)
        trans = Transaction.find_by(id: id_trans)
        if trans == nil 
            return
        end
        #appel API de remboursement
        pg_success = true #provisoirement

        if !pg_success
            return
        end
        trans.date_received = DateTime.now
        trans.taux_entree = Transaction::TAUX_ENT
        trans.taux_sortie = Transaction::TAUX_SORT
        trans.taux_preteur = Transaction::TAUX_PRET
        
        trans.save
    end

    def finalisation_transaction (identifier, tx_reference, payment_reference)
        trans = Transaction.find_by(id: identifier)
        if trans == nil 
            return
        end
        demande = Demande.find_by(id: trans.demande_id)
        if demande == nil 
            return
        end
        #Modifier la ligne de transaction
        dt = DateTime.now
        trans.tx_reference = tx_reference
        trans.payment_reference = payment_reference
        date_envoi = dt
        trans.save 
        #transférer l'argent au destinataire
        envoi_argent trans.id
        #modifier la ligne de la demande
        if trans.is_envoi #si is_envoi = 1 alors c'est le prêt sinon le remboursement
            demande.date_disbursed = dt 
            demande.repayment_date = dt + demande.nombre_de_jour * 1.day.seconds
            demande.lender_phone = trans.sender_phone
            demande.amount_to_repay = demande.amount_borrowed * (1 + demande.taux) 
            demande.total_amount_paid = 0
            demande.status = demande.status.to_i | (2**Demande.cond_status_accepte)

        else
            demande.total_amount_paid += trans.amount  
            if demande.total_amount_paid >= demande.amount_to_repay
               demande.date_repaid = dt
               demande.status = demande.status.to_i | (2**Demande.cond_status_paye)
            end
        end
        
        demande.save
    end

end



