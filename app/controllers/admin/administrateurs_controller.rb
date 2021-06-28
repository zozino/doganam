class Admin::AdministrateursController < ApplicationController
#Page de connexion Admin
#Liste des comptes Admin
#Page de création de compte
#Page de modification de compte
#Suppression d'un compte

  def index
    if !connected?
      return
    end
    @liste = Admin.all
  end

  def show
    if !connected?
      return
    end
    @admin = Admin.find_by(id: current_admin_id)
  end

  def new
    if !connected?
      return
    end
    @errors = session[:errors]; session[:errors] = []
    @admin = Admin.new
  end

  def create
    if !connected?
      return
    end
    @errors = []
    if params[:username].nil? || params[:username].empty? then
      @errors.push "Le nom d'utilisateur n'est pas renseigné"
    elsif !Admin.find_by(username: params[:username]).nil?
      @errors.push "Cet utilisateur existe déjà!"
    end

      session[:errors] = @errors
    if @errors.length > 0

      return
    end
    ###########################################################
    @admin = Admin.new(admin_params)
    
    if @admin.save
      redirect_to "/admin/liste_admin"
      return
    end

    redirect_to "/admin/connect_page"
  end

  def edit
    if !connected?
      return
    end
    @admin = Admin.find_by(id: params[:id])
  end

  def update
    if !connected?
      return
    end
    @admin = Admin.find_by(id: params[:id])
    @errors = []
    if @admin.nil?
      @errors.push "Compte d'admin inexistant"
    end
    if params[:username].nil? || params[:username].empty? then
      @errors.push "Le nom d'utilisateur n'est pas renseigné"
    else
      @other_admins = Admin.where(username: params[:username]).where.not(id: params[:id])
      if !@other_admins.nil? && !@other_admins.empty?
        @errors.push "Cet utilisateur existe déjà!"
      end
    end

    if @errors.length > 0
      return
    end
    ###########################################################
    
    if @admin.update(admin_params)
      redirect_to "/admin/liste_admin"
    end
  end

  def connect_page
    @errors = session[:errors]; session[:errors] = []
  end

  def connect_access
    @errors = []
    @other_admin = Admin.where(username: params[:username])
                        .where(password_digest: params[:password_digest])
    puts(@other_admin)
    if @other_admin.nil? || @other_admin.empty?
      @errors.push "Veuillez vérifier votre nom d'utilisateur ou votre mot de passe"

      session[:errors] = @errors
      redirect_to "/admin/connect_page"
      return
    end

    session[:current_admin_id] = @other_admin[0].id

    redirect_to "/admin/liste_admin"
  end

  def destroy
    @admin = Admin.find_by(id: params[:id])
    @admin.destroy

    redirect_to "/admin/liste_admin"
  end

  def deconnect
    session[:current_admin_id] = 0
    redirect_to "/admin/connect_page"
  end

private
  def admin_params
    params.permit(:id, :username, :password_digest)
  end

  def connected?
    if current_admin_id.nil? or current_admin_id == 0
      redirect_to "/admin/connect_page"
      false
    end
    true
  end

  def current_admin_id
    session[:current_admin_id]
  end
end
