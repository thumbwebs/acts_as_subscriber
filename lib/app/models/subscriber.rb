class Channel_Subscriber < ActiveResource::Base
 
  # In the case where you already have an existing model with the same name as the desired 
  # RESTful resource you can set the element_name value
  self.element_name = "channel_subscriber"
  
  # self.site = "http://thumbwebs.com"   <= production
  self.site = "http://localhost:3000"

  # sets timeout -defaults to 60 seconds which is too much to tie up a thread.
  self.timeout = 5
  
  ## basic authenication
  self.username = @@thumbwebs_username
  self.password = @@thumbwebs_password
  
  
  ## api authenication
  def authenication(uid,message,http_date)

    
    # (ex. Sat, 12 Jul 2008 09:04:28 GMT)
   # http_date =  Time.now.httpdate  
    #@headers["Content-Type"] = "text/html; charset=utf-8" # general purpose
    
    parameters = "user_id=#{uid}&body=#{CGI.escape(message)}"
    # => "user_id=1234&body=Art+thou+not+Romeo%2C+and+a+Montague%3F"
    
    canonical_string = "#{@@thumbwebs_api}#{http_date}#{parameters}"
    # => "cef7a046258082993759bade995b3ae8Sat, 12 Jul 2008 09:04:55 GMTuser_id=1234&body=Art+thou+not+Romeo%2C+and+a+Montague%3F"

    digest = OpenSSL::Digest::Digest.new('sha1')
  
    b64_mac = Base64.encode64(OpenSSL::HMAC.digest(digest, @@thumbwebs_secret_key, canonical_string)).strip
  
    authentication = "Thumbwebs #{API_KEY}:#{b64_mac}"
         
  end
end  