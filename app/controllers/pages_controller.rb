class PagesController < ApplicationController

  def accueil

  end 


  def ficheinfodemandeur

  end
  
  def corrigercompte

  end
  
  def infodemandeur
    @demande = Demande.find_by(id: params[:id])
    @demandeur = Utilisateur.find_by(id: @demande.utilisateur_id)
  end
  
  def acceptpret
    @demande = Demande.find_by(id: params[:id])
    if @demande.date_disbursed != nil
      redirect_to "/"
      return
    end
    @user = Utilisateur.find_by(id: @demande.utilisateur_id)
    if @user.status.to_i != Utilisateur.status_active
      redirect_to "/"
      return
    end
  end

  def demandepret
    @error = ""
    if Utilisateur.pret_encours? current_user_id
      @error = "Cet utlisateur a déjà soumis une demande de prêt"
      puts @error
      redirect_to "/histopretssollicites"
      return
    else
      @categories = Category.all
      @deadlines = Deadline.all
      @user = Utilisateur.find_by(id: current_user_id)
      @demande = Demande.new 
    end
  end
 
  def demandepretvalider
    if Utilisateur.pret_encours? current_user_id
      @error = "Cet utlisateur a déjà soumis une demande de prêt"
      puts @error
      redirect_to "/histopretssollicites"
      return
    end
    
    dt_acc = 0.hour.from_now.localtime
    @user = Utilisateur.find_by(id: current_user_id)
    
    @demande = Demande.new(demande_params)
    @demande[:utilisateur_id] = current_user_id
    if @user.status.to_i == Utilisateur.status_active
      @demande[:date_accepted] = dt_acc
      @demande[:status] = Demande.status_en_attente_pret
      print "Etat en attente"
    else 
      @demande[:date_accepted] = nil
      @demande[:status] = Demande.status_cpt_non_valide_nonexpire
      print "Etat non valide"
    end
    @demande[:penalty_amount] = @demande.taux * @demande.amount_borrowed
    @demande[:total_amount_paid] = 0

    if @demande.save 
      redirect_to "/evolutiondemande"
    else
      render :soumission_demande
    end
  end

  def evolutiondemande
    @demande = Demande.order(id: :desc).where("utilisateur_id = #{current_user_id}").first
    
    @user = Utilisateur.find_by(id: current_user_id)
  end

  def rembourspret
    @demande = Demande.find_by(id: params[:id])
    @user = Utilisateur.find_by(id: current_user_id)
  end



def createcompte
  @user = Utilisateur.new
  @deadlines = Deadline.all
end 

def createcomptevalider
  puts params
  @user_exists = Utilisateur.find_by(phone: params[:phone])
  @error = ""

  if @user_exists != nil 
    @error = "Un compte de même n° de téléphone exist déjà!"
    redirect_to "/register"
    return
  end

  @user = Utilisateur.new(user_params)
  @user.status = Utilisateur.status_en_attente

  @user.id_document_url = Utilisateur.create_file_from_upload_data(
    params[:id_document_url], 
    Utilisateur.user_img_dir
  )
  @user.photo_url = Utilisateur.create_file_from_upload_data(
    params[:photo_url], 
    Utilisateur.user_img_dir
  )

  if @user.save
    redirect_to "/login"
  else
  end
end

def corrigercompte
  @user = Utilisateur.find_by(id: session[:current_user_id])
end 

def corrigercomptevalider
  @user = Utilisateur.find_by(id: session[:current_user_id])    
  if params[:id_document_url] != nil && params[:id_document_url] != ""
    params[:id_document_url] = Utilisateur.create_file_from_upload_data(
      params[:id_document_url], 
      Utilisateur.user_img_dir
    )
  end
  if params[:photo_url] != nil && params[:photo_url] != ""
    params[:photo_url] = Utilisateur.create_file_from_upload_data(
      params[:photo_url], 
      Utilisateur.user_img_dir
    )
  end

  if @user.update user_params
    redirect_to "/"
  else
    
  end
end

def connexion

end

def connexionvalider
  @user = Utilisateur.find_by(phone: params[:phone])
  @error = ""
  

  if @user == nil
    @error = "Ce compte n'existe pas"

  else
    if @user.password_digest != params[:password]
      @error = "Veuillez reverifier les informations de votre compte"

    else
      #les informations du compte sont correctes
      #Il peut se connecter
      session[:current_user_id] = @user.id
      redirect_to "/histopretssollicites"
    end 
  end

end

  def deconnecter
    session[:current_user_id] = 0

    redirect_to accueil_path
  end

  private
  def user_params
    params.permit(
      :nom,
      :prenoms,
      :age,
      :sexe,
      :quartier,
      :id_document_url,
      :photo_url,
      :password_digest,
      :phone,
      :pseudo)
  end

  def demande_params
    params.permit(
      :utilisateur_id,
      :nombre_de_jour,
      :taux,
      :date_accepted,
      :date_disbursed,
      :date_repaid,
      :repayment_date,
      :penalty_amount,##
      :total_amount_paid,##
      :lender_phone,
      :is_anonymous,
      :amount_borrowed,##
      :amount_to_repay,##
      :category_id,
      :phone,
      :status
    )
  end

  def current_user_id
    session[:current_user_id]
  end
end
