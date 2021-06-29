class Utilisateur < ApplicationRecord

    def monAge
        age + Utilisateur.years_between_dates(created_at)
    end

    def self.status_en_attente
        0
    end
    def self.status_invalide
        1
    end
    def self.status_active
        2
    end

    def self.pret_encours? (user_id)
        @demande = Demande.order("created_at": :desc).where("utilisateur_id = #{user_id}").first;

        if @demande == nil
            puts "Demande inexistante"
            return false
        elsif @demande.date_repaid != nil
            
            puts "Demande payée"
            return false
        end

        return true
    end

    def self.years_between_dates(date_from, date_to)
        ((date_to.to_time - date_from.to_time) / 1.year.seconds).floor
    end

    def self.years_between_dates(date_from)
        #puts "#{DateTime.now}  #{DateTime.now}  #{DateTime.now.to_i}"
        #puts "#{date_from}"
        if date_from.instance_of? String
            t_date_from = DateTime.parse(date_from)
        else
           t_date_from = DateTime.parse(date_from.to_s) 
        end
        #puts "DateTime.now  => #{DateTime.now}"
        #puts "t_date_from.to_time  => #{t_date_from.to_time}"
        #puts "t_date_from  => #{t_date_from}"
        ((DateTime.now - t_date_from)/ 1.year.seconds).floor
    end

    def self.toString(ladate)
        if ladate == nil
          "-"
        else
          ladate.strftime("%d/%m/%Y")
        end 
    end
    
    def self.create_file_from_upload_data(data, dir)
        if ! (File.directory? dir)
            puts "#{dir} pas un dossier"
            return false
        end
        
        #if data.original_filename = ""
        #    puts "original_filename pas là"
        #    return false
        #end
        if data.nil? || data == "" || (!data.member? tempfile)
            puts "tempfile pas là"
            return false
        end
        name = File.basename(data.original_filename)
        ext = File.extname(data.original_filename)
        name = name.split(ext)[0]
        filename = "#{dir}/#{name}_#{sprintf("%05d", (rand 0..99999))}#{ext}"
        
        
        in_file = data.tempfile.open()
        out_file = File.new(filename, "wb")
        #...
        x = ""
        while in_file.read(1, x)
            out_file.putc x
        end
        #...
        out_file.close

        File.basename(filename)
    end

    def self.user_img_dir        
        "#{Dir.getwd}/app/assets/images/from_users"
    end

    def self.user_img_url(filename)        
        "/from_users/#{filename}"
    end

    def self.asset_exists?(path)
        if Rails.env.production?  
            Rails.application.assets_manifest.find_sources(path) != nil
        else
            Rails.application.assets.find_asset(path) != nil
        end
    end
end
