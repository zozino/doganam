class Admin::TransactionsController < ApplicationController    
    #Liste des demandes par Emprunteur, 
    #dans une période donné, selon leurs états 
    #(créées par des comptes non validés, 
    #    en attente pour prêt, 
    #    prêt accepté, remboursé, 
    #    non remboursé)
    def recherche
        puts "params = |#{params}|"
        @liste = Demande.demandes(params)
    end
end
