class GlobalmethodesController < ApplicationController

    def init_data
        i = 1
        Deadline.delete_all
        Deadline.create(:id => i, :nombre_de_jour => 7, :tax => 0.1); i+=1;
        Deadline.create(:id => i, :nombre_de_jour => 14, :tax => 0.15); i+=1;

        i = 1
        Category.delete_all
        Category.create(:id => i, :nom => "Urgence médicale"); i+=1;
        Category.create(:id => i, :nom => "Transport"); i+=1;
        Category.create(:id => i, :nom => "Nourriture"); i+=1;
        Category.create(:id => i, :nom => "Prêt"); i+=1;
        Category.create(:id => i, :nom => "Facture d'eau"); i+=1;
        Category.create(:id => i, :nom => "Facture d'électricité"); i+=1;
        Category.create(:id => i, :nom => "Santé")

        i = 1
        Quartier.delete_all
        Quartier.create( id: i, nom: "ABLOGAME"); i+=1;
        Quartier.create( id: i, nom: "ABOBOKOME"); i+=1;
        Quartier.create( id: i, nom: "ADAKPAME"); i+=1;
        Quartier.create( id: i, nom: "ADAKPAME-NETADI"); i+=1;
        Quartier.create( id: i, nom: "ADAWLATO"); i+=1;
        Quartier.create( id: i, nom: "ADIDOGOME"); i+=1;
        Quartier.create( id: i, nom: "ADIDOGOME MASSALASSI"); i+=1;
        Quartier.create( id: i, nom: "ADMINISTRATIF"); i+=1;
        Quartier.create( id: i, nom: "AFLAO GAKLI"); i+=1;
        Quartier.create( id: i, nom: "AFLAO SAGBADO"); i+=1;
        Quartier.create( id: i, nom: "AFLAO TOTSI"); i+=1;
        Quartier.create( id: i, nom: "AGBALEPEDOGAN"); i+=1;
        Quartier.create( id: i, nom: "AGOE NYIVE"); i+=1;
        Quartier.create( id: i, nom: "AGUIARKOME"); i+=1;
        Quartier.create( id: i, nom: "AKATO"); i+=1;
        Quartier.create( id: i, nom: "AKODESSEWA"); i+=1;
        Quartier.create( id: i, nom: "AKODESSEWA KPOTA"); i+=1;
        Quartier.create( id: i, nom: "AMADAHOME"); i+=1;
        Quartier.create( id: i, nom: "AMOUTIVE"); i+=1;
        Quartier.create( id: i, nom: "ANFAME"); i+=1;
        Quartier.create( id: i, nom: "APEDOKOE"); i+=1;
        Quartier.create( id: i, nom: "ATIKOUME"); i+=1;
        Quartier.create( id: i, nom: "ATTIEGOU"); i+=1;
        Quartier.create( id: i, nom: "ATTIKPA"); i+=1;
        Quartier.create( id: i, nom: "AVEDJI"); i+=1;
        Quartier.create( id: i, nom: "AVEDJI - SITO"); i+=1;
        Quartier.create( id: i, nom: "AWATAME"); i+=1;
        Quartier.create( id: i, nom: "BAGUIDA"); i+=1;
        Quartier.create( id: i, nom: "BASSADJI"); i+=1;
        Quartier.create( id: i, nom: "BATOME"); i+=1;
        Quartier.create( id: i, nom: "BE ABLOGAME"); i+=1;
        Quartier.create( id: i, nom: "BE ADJROMETI"); i+=1;
        Quartier.create( id: i, nom: "BE GBENYEDZI KOPE"); i+=1;
        Quartier.create( id: i, nom: "BE KAMALODO"); i+=1;
        Quartier.create( id: i, nom: "BE -KLIKAME"); i+=1;
        Quartier.create( id: i, nom: "BE KPOTA"); i+=1;
        Quartier.create( id: i, nom: "BE PA DE SOUZA"); i+=1;
        Quartier.create( id: i, nom: "BE SOUZA NETIME"); i+=1;
        Quartier.create( id: i, nom: "BIOSSE"); i+=1;
        Quartier.create( id: i, nom: "CAISSE"); i+=1;
        Quartier.create( id: i, nom: "DANGBUIPE"); i+=1;
        Quartier.create( id: i, nom: "DOULASSAME"); i+=1;
        Quartier.create( id: i, nom: "ETOILES"); i+=1;
        Quartier.create( id: i, nom: "FOREVER"); i+=1;
        Quartier.create( id: i, nom: "GBENYEDZI KOPE"); i+=1;
        Quartier.create( id: i, nom: "GBETSOGBE"); i+=1;
        Quartier.create( id: i, nom: "HANOUKOPE"); i+=1;
        Quartier.create( id: i, nom: "HEDZRANAWOE"); i+=1;
        Quartier.create( id: i, nom: "KANGNIKOPE"); i+=1;
        Quartier.create( id: i, nom: "KELEGOUGAN"); i+=1;
        Quartier.create( id: i, nom: "KELEGOUGAN NASOD"); i+=1;
        Quartier.create( id: i, nom: "KLEME"); i+=1;
        Quartier.create( id: i, nom: "KODJOVIAKOPE"); i+=1;
        Quartier.create( id: i, nom: "KOKETIME"); i+=1;
        Quartier.create( id: i, nom: "LANKOUVI"); i+=1;
        Quartier.create( id: i, nom: "LEGBASSITO"); i+=1;
        Quartier.create( id: i, nom: "LOM-NAVA"); i+=1;
        Quartier.create( id: i, nom: "N'KAFU"); i+=1;
        Quartier.create( id: i, nom: "N'TIFAFA KOME"); i+=1;
        Quartier.create( id: i, nom: "NYEKONAKPOE"); i+=1;
        Quartier.create( id: i, nom: "SAGBADO"); i+=1;
        Quartier.create( id: i, nom: "SANGUERA"); i+=1;
        Quartier.create( id: i, nom: "SEGBE"); i+=1;
        Quartier.create( id: i, nom: "SOVIEPE"); i+=1;
        Quartier.create( id: i, nom: "TOGBLE KOPE"); i+=1;
        Quartier.create( id: i, nom: "TOKOIN"); i+=1;
        Quartier.create( id: i, nom: "TOKOIN DOGBEAVOU"); i+=1;
        Quartier.create( id: i, nom: "TOKOIN DOUMASSESSE"); i+=1;
        Quartier.create( id: i, nom: "TOKOIN ELAVAGNON"); i+=1;
        Quartier.create( id: i, nom: "TOKOIN GBONVIE"); i+=1;
        Quartier.create( id: i, nom: "TOKOIN NOVISSI"); i+=1;
        Quartier.create( id: i, nom: "TOKOIN SEMINAIRE"); i+=1;
        Quartier.create( id: i, nom: "TOKOIN SOLIDARITE"); i+=1;
        Quartier.create( id: i, nom: "TOKOIN SOLIDARITE"); i+=1;
        Quartier.create( id: i, nom: "TOKOIN TAME"); i+=1;
        Quartier.create( id: i, nom: "TOTSI"); i+=1;
        Quartier.create( id: i, nom: "VAKPOSSITO"); i+=1;
        Quartier.create( id: i, nom: "VOGOME"); i+=1;
        Quartier.create( id: i, nom: "WONYOME"); i+=1;
        Quartier.create( id: i, nom: "WUITI"); i+=1;
        Quartier.create( id: i, nom: "YOKOE"); i+=1;

        Quartier.create( id: i, nom: "TOGBLE KOPE"); i+=1;
        Quartier.create( id: i, nom: "TSEVIE"); i+=1;
        Quartier.create( id: i, nom: "KPALIME"); i+=1;
        Quartier.create( id: i, nom: "ATAKPAME"); i+=1;
        Quartier.create( id: i, nom: "KARA"); i+=1;
        Quartier.create( id: i, nom: "DAPAONG"); i+=1;
        Quartier.create( id: i, nom: "NOTSE"); i+=1;
        Quartier.create( id: i, nom: "VOGAN"); i+=1;
        Quartier.create( id: i, nom: "SOKODE"); i+=1;
        Quartier.create( id: i, nom: "ADETIKOPE"); i+=1;
        Quartier.create( id: i, nom: "MANGO"); i+=1;
        Quartier.create( id: i, nom: "AUTRES")

    end
end
