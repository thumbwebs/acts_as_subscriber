class Thumbwebs::Subscriber  < ActiveResource::Base 
 
  # In the case where you already have an existing model with the same name as the desired 
  # RESTful resource you can set the element_name value
  # self.element_name = "subscriber"
  # self.site = "http://thumbwebs.com"   <= production
  ## Subscribers is nested under channels on server

  # this will nest subscribers under channels
  self.site = "#{THUMBWEBS_SITE_URL}channels/#{THUMBWEBS_CHANNEL_ID}/"

  #self.prefix = 'backend'

  # sets timeout -defaults to 60 seconds which is too much to tie up a thread.
  self.timeout = 10

  ## basic authenication

  ## get working with basic authenication which is the present rails way
  ## and then we can work on api authenication
  self.user = THUMBWEBS_USERNAME
  self.password = THUMBWEBS_PASSWORD
  
  
end  