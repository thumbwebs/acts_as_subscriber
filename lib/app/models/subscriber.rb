class Subscriber <  Thumbwebs
 
  # In the case where you already have an existing model with the same name as the desired 
  # RESTful resource you can set the element_name value
  # self.element_name = "subscriber"
  # self.site = "http://thumbwebs.com"   <= production
  self.site = "http://localhost:3000"

  #self.prefix = 'backend'

  # sets timeout -defaults to 60 seconds which is too much to tie up a thread.
  self.timeout = 5

  ## basic authenication

  ## get working with basic authenication which is the present rails way
  ## and then we can work on api authenication
  self.username = "#{THUMBWEBS_PASSWORD}|{#THUMBWEBS_CHANNEL_ID}#{THUMBWEBS_API}"
  self.password = @@thumbwebs_password
  
  
end  