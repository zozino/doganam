class GlobalmethodesController < ApplicationController

    def init_data
        i = 1
        Deadlines.delete_all
        Deadlines.create(:id => i, :nombre_de_jour => 7, :tax => 0.1); i++;
        Categories.create(:id => i, :nombre_de_jour => 14, :tax => 0.15); i++;

        i = 1
        Categories.delete_all
        Categories.create(:id => i, :nom => "Urgence médicale"); i++;
        Categories.create(:id => i, :nom => "Transport"); i++;
        Categories.create(:id => i, :nom => "Nourriture"); i++;
        Categories.create(:id => i, :nom => "Prêt"); i++;
        Categories.create(:id => i, :nom => "Facture d'eau"); i++;
        Categories.create(:id => i, :nom => "Facture d'électricité"); i++;
        Categories.create(:id => i, :nom => "Santé")
        
        i = 1
        Quartier.delete_all
        Quartier.create( id: i, nom: "ABLOGAME"); i++;
        Quartier.create( id: i, nom: "ABOBOKOME"); i++;
        Quartier.create( id: i, nom: "ADAKPAME"); i++;
        Quartier.create( id: i, nom: "ADAKPAME-NETADI"); i++;
        Quartier.create( id: i, nom: "ADAWLATO"); i++;
        Quartier.create( id: i, nom: "ADIDOGOME"); i++;
        Quartier.create( id: i, nom: "ADIDOGOME MASSALASSI"); i++;
        Quartier.create( id: i, nom: "ADMINISTRATIF"); i++;
        Quartier.create( id: i, nom: "AFLAO GAKLI"); i++;
        Quartier.create( id: i, nom: "AFLAO SAGBADO"); i++;
        Quartier.create( id: i, nom: "AFLAO TOTSI"); i++;
        Quartier.create( id: i, nom: "AGBALEPEDOGAN"); i++;
        Quartier.create( id: i, nom: "AGOE NYIVE"); i++;
        Quartier.create( id: i, nom: "AGUIARKOME"); i++;
        Quartier.create( id: i, nom: "AKATO"); i++;
        Quartier.create( id: i, nom: "AKODESSEWA"); i++;
        Quartier.create( id: i, nom: "AKODESSEWA KPOTA"); i++;
        Quartier.create( id: i, nom: "AMADAHOME"); i++;
        Quartier.create( id: i, nom: "AMOUTIVE"); i++;
        Quartier.create( id: i, nom: "ANFAME"); i++;
        Quartier.create( id: i, nom: "APEDOKOE"); i++;
        Quartier.create( id: i, nom: "ATIKOUME"); i++;
        Quartier.create( id: i, nom: "ATTIEGOU"); i++;
        Quartier.create( id: i, nom: "ATTIKPA"); i++;
        Quartier.create( id: i, nom: "AVEDJI"); i++;
        Quartier.create( id: i, nom: "AVEDJI - SITO"); i++;
        Quartier.create( id: i, nom: "AWATAME"); i++;
        Quartier.create( id: i, nom: "BAGUIDA"); i++;
        Quartier.create( id: i, nom: "BASSADJI"); i++;
        Quartier.create( id: i, nom: "BATOME"); i++;
        Quartier.create( id: i, nom: "BE ABLOGAME"); i++;
        Quartier.create( id: i, nom: "BE ADJROMETI"); i++;
        Quartier.create( id: i, nom: "BE GBENYEDZI KOPE"); i++;
        Quartier.create( id: i, nom: "BE KAMALODO"); i++;
        Quartier.create( id: i, nom: "BE -KLIKAME"); i++;
        Quartier.create( id: i, nom: "BE KPOTA"); i++;
        Quartier.create( id: i, nom: "BE PA DE SOUZA"); i++;
        Quartier.create( id: i, nom: "BE SOUZA NETIME"); i++;
        Quartier.create( id: i, nom: "BIOSSE"); i++;
        Quartier.create( id: i, nom: "CAISSE"); i++;
        Quartier.create( id: i, nom: "DANGBUIPE"); i++;
        Quartier.create( id: i, nom: "DOULASSAME"); i++;
        Quartier.create( id: i, nom: "ETOILES"); i++;
        Quartier.create( id: i, nom: "FOREVER"); i++;
        Quartier.create( id: i, nom: "GBENYEDZI KOPE"); i++;
        Quartier.create( id: i, nom: "GBETSOGBE"); i++;
        Quartier.create( id: i, nom: "HANOUKOPE"); i++;
        Quartier.create( id: i, nom: "HEDZRANAWOE"); i++;
        Quartier.create( id: i, nom: "KANGNIKOPE"); i++;
        Quartier.create( id: i, nom: "KELEGOUGAN"); i++;
        Quartier.create( id: i, nom: "KELEGOUGAN NASOD"); i++;
        Quartier.create( id: i, nom: "KLEME"); i++;
        Quartier.create( id: i, nom: "KODJOVIAKOPE"); i++;
        Quartier.create( id: i, nom: "KOKETIME"); i++;
        Quartier.create( id: i, nom: "LANKOUVI"); i++;
        Quartier.create( id: i, nom: "LEGBASSITO"); i++;
        Quartier.create( id: i, nom: "LOM-NAVA"); i++;
        Quartier.create( id: i, nom: "N'KAFU"); i++;
        Quartier.create( id: i, nom: "N'TIFAFA KOME"); i++;
        Quartier.create( id: i, nom: "NYEKONAKPOE"); i++;
        Quartier.create( id: i, nom: "SAGBADO"); i++;
        Quartier.create( id: i, nom: "SANGUERA"); i++;
        Quartier.create( id: i, nom: "SEGBE"); i++;
        Quartier.create( id: i, nom: "SOVIEPE"); i++;
        Quartier.create( id: i, nom: "TOGBLE KOPE"); i++;
        Quartier.create( id: i, nom: "TOKOIN"); i++;
        Quartier.create( id: i, nom: "TOKOIN DOGBEAVOU"); i++;
        Quartier.create( id: i, nom: "TOKOIN DOUMASSESSE"); i++;
        Quartier.create( id: i, nom: "TOKOIN ELAVAGNON"); i++;
        Quartier.create( id: i, nom: "TOKOIN GBONVIE"); i++;
        Quartier.create( id: i, nom: "TOKOIN NOVISSI"); i++;
        Quartier.create( id: i, nom: "TOKOIN SEMINAIRE"); i++;
        Quartier.create( id: i, nom: "TOKOIN SOLIDARITE"); i++;
        Quartier.create( id: i, nom: "TOKOIN SOLIDARITE"); i++;
        Quartier.create( id: i, nom: "TOKOIN TAME"); i++;
        Quartier.create( id: i, nom: "TOTSI"); i++;
        Quartier.create( id: i, nom: "VAKPOSSITO"); i++;
        Quartier.create( id: i, nom: "VOGOME"); i++;
        Quartier.create( id: i, nom: "WONYOME"); i++;
        Quartier.create( id: i, nom: "WUITI"); i++;
        Quartier.create( id: i, nom: "YOKOE"); i++;

        Quartier.create( id: i, nom: "TOGBLE KOPE"); i++;
        Quartier.create( id: i, nom: "TSEVIE"); i++;
        Quartier.create( id: i, nom: "KPALIME"); i++;
        Quartier.create( id: i, nom: "ATAKPAME"); i++;
        Quartier.create( id: i, nom: "KARA"); i++;
        Quartier.create( id: i, nom: "DAPAONG"); i++;
        Quartier.create( id: i, nom: "NOTSE"); i++;
        Quartier.create( id: i, nom: "VOGAN"); i++;
        Quartier.create( id: i, nom: "SOKODE"); i++;
        Quartier.create( id: i, nom: "ADETIKOPE"); i++;
        Quartier.create( id: i, nom: "MANGO"); i++;
        Quartier.create( id: i, nom: "AUTRES")

    end
end
