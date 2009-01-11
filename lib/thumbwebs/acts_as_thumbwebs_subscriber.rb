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
        @subscriber= Thumbwebs::Subscriber.find(self.id)
        Thumbwebs::Subscriber.find(:all, :params => {:email => self.email,
                                          :channel_id  => THUMBWEBS_CHANNEL_ID,
                                          :uid => self.id})
      rescue ActiveResource::ResourceNotFound
        return false
      end  
   end  
   
   def register_thumbwebs
     Subscriber.new(:name => self.username,:email => self.email).post(:register)
   end   
  end
end
