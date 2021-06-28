

class Otp < ApplicationRecord
    def self.generate_code
        sprintf("%06d", rand(100..999998))
    end

end
