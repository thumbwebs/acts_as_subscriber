module Thumbwebs
  def self.included(base)
    base.send :extend, ClassMethods
  end

  module ClassMethods

    # any method placed here will apply to classes, like User
    def acts_as_thumbwebs_subscriber(options = {})
      
      send :include, InstanceMethods
    end
  end

  module InstanceMethods
    
    # any method placed here will apply to instances, like @user
  def is_thumbwebs_subscriber?(options = {})
      begin
    
        @subscriber = Thumbwebs::Subscriber.find(:all, :params => {:email => self.email,
                                                          :api => 12345,        :uid => self.id})
      rescue  ActiveResource::ResourceNotFound
        logger.info "Thumbwebs:  user not found."
        return false
      rescue ActiveResource::ForbiddenAccess
        logger.info "Thumbwebs: Forbidden Access for #{self.email}"
      rescue ActiveResource::UnauthorizedAccess 
        logger.info "Thumbwebs: UnauthorizedAccess for #{self.email}"
       # logger.info request.env["Api Status"]
        return false
      rescue 
        logger.info "Thumbwebs: Other error."
        return false
      else
        logger.info "Thumbwebs: Success. #{self.email} is a subscriber "
        #logger.info request.env["Api Status"]
        return true
      end  
  end
   
   def register_thumbwebs
     Subscriber.new(:name => self.username,:email => self.email).post(:register)
   end   

end
end
