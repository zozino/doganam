Rails.application.routes.draw do
  namespace :admin do
    get 'liste_admin', to: 'administrateurs#index'
    get 'show_admin', to: 'administrateurs#show'
    get 'new_admin', to: 'administrateurs#new'
    get 'create_admin', to:'administrateurs#create'
    post 'create_admin', to: 'administrateurs#create'
    get 'edit_admin/:id', to: 'administrateurs#edit'
    post 'update_admin', to: 'administrateurs#update'
    get 'connect_page', to: 'administrateurs#connect_page'
    post 'connect_access', to: 'administrateurs#connect_access'
    get 'delete_admin/:id', to: 'administrateurs#destroy'
    get 'deconnect', to: 'administrateurs#deconnect'

    get 'liste_en_attente_emp', to: 'emprunteurs#liste_en_attente'
    get 'liste_valide_emp', to: 'emprunteurs#liste_valide'
    get 'liste_invalide_emp', to: 'emprunteurs#liste_invalide'
    post 'info_emp', to: 'emprunteurs#info'
    post 'valider_cmp_emp', to: 'emprunteurs#valider_compte'
    post 'invalider_cmp_emp', to: 'emprunteurs#invalider_compte'



    get 'home', to: 'dashboards#dashboard'
    post 'home', to: 'dashboards#dashboard'
    get 'transaction', to: 'dashboards#transaction'

    get 'demandes', to: 'demandes#recherche_demandes'
    post 'demandes', to: 'demandes#recherche_demandes'

    get 'transactions', to: 'transactions#recherche'
    post 'transactions', to: 'transactions#recherche'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html


  #root des pages 
  root to: 'pages#accueil'


  get 'init_data', to:'globalmethodes#init_data'
  get 'createcompte', to:'pages#createcompte'
  get 'login', to:'pages#connexion'
  get 'solliciterpret', to:'pages#demandepret'
  get 'evolutiondemande', to:'pages#evolutiondemande'
  post 'rembourser', to:'pages#rembourspret'
  get 'infodemandeur', to:'pages#ficheinfodemandeur'
  get 'corriger', to:'pages#corrigercompte'
  post 'updateuser', to:'pages#corrigercomptevalider'
  get 'acceptpret/:id', to:'pages#acceptpret'
  post 'demandepretvalider', to:'pages#demandepretvalider'

  post 'connexionvalider', to:'pages#connexionvalider'
  post 'register', to:'pages#createcomptevalider'
  post 'supprimer', to: 'pages#delete_demande'

  # root des listes
  get 'home', to:'pages#home'
  get 'histopretsaccordes', to:'listes#histopretsaccordes'
  post 'histopretsaccordes', to:'listes#histopretsaccordes'
  get 'listedemandepret', to:'listes#listesdemandesprets'
  get 'histopretssollicites', to:'listes#histopretssollicites'
  get 'listenoire', to:'listes#noire'

  #routes vers les méthodes paygate
  post 'paygateaccepterpret', to: 'paygate#paygateaccepterpret'
  post 'paygaterembourser', to: 'paygate#paygaterembourser'
end
