class Admin::DemandesController < ApplicationController
    #Liste des demandes par Emprunteur, 
    #dans une période donné, selon leurs états 
    #(créées par des comptes non validés, 
    #    en attente pour prêt, 
    #    prêt accepté, remboursé, 
    #    non remboursé)
    def recherche_demandes
        puts "params = |#{params}|"
        @liste_demandes = Demande.demandes(params)
    end

end
