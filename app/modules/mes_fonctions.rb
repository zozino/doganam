
module SMS 
    def sms_alert(from, to, text)
        #http://cybetcast.net:60001/cgi-bin/sendsms?username=moov&password=moov&from=BHK&to=99699200&text=BONJOUR
        uri = URI('http://example.com/index.html')
        params = { 
            :username => "moov",
            :password => "moov",
            :from => from
            :to => to,
            :text => text
        }
        uri.query = URI.encode_www_form(params)

        res = Net::HTTP.get_response(uri)
        puts res.body if res.is_a?(Net::HTTPSuccess)
    end

end
