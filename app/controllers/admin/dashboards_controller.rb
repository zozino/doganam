class Admin::DashboardsController < ApplicationController
#nombre_de_prets
#montant_solde
#nombre_quartiers
	def dashboard
		init_dashboard

		session[:dashboard].each do |key_0, stat|
			bool = false
			data = {}
			filtre = {}
			stat["filtre"].each do |key_1, val|
				if params.has_key? key_0
					filtre[key_1] = params[key_0][key_1]
					bool = true
				end
			end

			data["filtre"] = bool ? filtre : stat["filtre"]
			data["donnees"] = nil
			data["actif"] = params.has_key?(key_0) && 
			params[key_0].has_key?("actif") ? 
			(params[key_0]["actif"].to_i > 0) : stat["actif"]


			if !stat["actif"]
				next
			end
			
			case key_0
			when "nombre_de_prets"
				obj = Demande.nombre_demandes(filtre)
				d = []
				obj.each do |item|
					an_objet = {}
					an_objet["label"] = Demande.all_status[item["status"].to_i]
					an_objet["value"] = item["nombre"]
					an_objet["filter"] = {"status" => item["status"].to_i}
					d.push an_objet
				end

				data["donnees"] = d
			when "montant_solde"
				obj = Transaction.revenus_paygate(filtre)
				som = 0
				obj.each do |item|
					som = som + item['entree'] - item['sortie']
				end
				puts obj
				data["donnees"] = som

			when "nombre_quartiers"
				data["donnees"]  = Demande.nombre_quartier(filtre)
			end
		
			session[:dashboard][key_0] = data
		end


	end 

	def nombre_de_pret

	end

	def transaction

	end

	def demandes

	end

private

	def init_dashboard()
		puts session[:dashboard]
		if !session.has_key? :dashboard
			tout = {}
			#nombre de pret
			data = {}
			filtre = {}
			filtre["dt_deb"] = ""
			filtre["dt_fin"] = ""
			filtre["phone"] = ""
			filtre["quartier"] = nil
			data["filtre"] = filtre
			data["donnees"] = nil
			data["actif"] = true
			tout["nombre_de_prets"] = data
			#montant solde sur Doganam
			data = {}
			filtre = {}
			filtre["dt_deb"] = ""
			filtre["dt_fin"] = ""
			data["filtre"] = filtre
			data["donnees"] = nil
			data["actif"] = true
			tout["montant_solde"] = data
			#nombre de quartiers sur Doganam
			data = {}
			filtre = {}
			filtre["dt_deb"] = ""
			filtre["dt_fin"] = ""
			data["filtre"] = filtre
			data["donnees"] = nil
			data["actif"] = true
			tout["nombre_quartiers"] = data
			##########################################
			session[:dashboard] = tout

		end
	end

end