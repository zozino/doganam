class ListesController < ApplicationController

  def listesdemandesprets
    query = <<-SQL
    SELECT D.id as id, nom, prenoms, U.phone, pseudo, quartier, sexe, age,
    D.nombre_de_jour,
    amount_borrowed, is_anonymous

    FROM Utilisateurs U JOIN Demandes D
    ON (U.id = D.utilisateur_id)
    WHERE U.status = #{Utilisateur.status_active}
    AND D.date_accepted is not null
    AND D.date_disbursed is null
    ORDER BY D.created_at DESC
    SQL
    @liste = Demande.select("*").from("(#{query})");

  end

  def noire
    query = <<-SQL
    SELECT pseudo, quartier, sexe, age,
    D.*, nom, prenoms, 
    U.id_document_url,
    U.photo_url

    FROM Utilisateurs U JOIN Demandes D
    ON (U.id = D.utilisateur_id)
    WHERE U.status = #{Utilisateur.status_active}
    AND D.repayment_date < date()
    AND D.date_repaid is null
    ORDER BY D.created_at DESC
    SQL
    @liste = Demande.select("*").from("(#{query})");
  end

  def histopretssollicites
    query = <<-SQL
    SELECT lender_phone, date_disbursed, 
    D.nombre_de_jour,
    amount_borrowed, repayment_date, date_repaid

    FROM Demandes D
    WHERE D.utilisateur_id = #{current_user_id}
    ORDER BY D.created_at DESC
    SQL
    @liste = Demande.select("*").from("(#{query})");
  end

  def histopretsaccordes
    prm = params.permit(:phone, :code);
    @num_phone = params[:phone]
    @code = params[:code]
    @error = ""
    @liste = []
    @liste_affiche = false

    @otp = nil



    if @num_phone == nil

    elsif @code == nil
      #Generer le code OTP
      @otp = Otp.find_by(num_phone: @num_phone)
      if @otp == nil 
        @otp = Otp.new
      end
      @otp.num_phone = @num_phone
      @otp.code = Otp.generate_code
      #enregistrer le nouveau code otp
      @otp.save
      #Envoi du code OTP par SMS
      PaygateController.sms_alert("DOGANAM", @num_phone, 
        "Utilisez ce code pour afficher votre historique de prets accordés:\n #{@otp.code}")
    else
      @otp = Otp.find_by num_phone: @num_phone, code: @code

      if @otp == nil
          #la liste ne sera pas chargée
        @error = "Resaissez votre numéro"
      else
          #la liste sera chargée
        query = <<-SQL
        SELECT pseudo, quartier, sexe, age, 
        U.created_at AS user_created_at,
        D.*

        FROM Demandes D JOIN Utilisateurs U
        ON (D.utilisateur_id = U.id)
        WHERE D.lender_phone = :phone
        AND D.date_accepted is not null
        AND D.date_disbursed is not null
        ORDER BY D.created_at DESC
        SQL
        @liste = Utilisateur.connection.execute(
          Utilisateur.sanitize_sql_for_assignment([query, phone: @num_phone])
        )
        #@liste = Demande.select("*").from("(#{query})");
        @liste_affiche = true
      end
    end

  end

private 
  def current_user_id
      session[:current_user_id]
  end  

end