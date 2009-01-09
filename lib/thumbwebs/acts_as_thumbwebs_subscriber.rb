module Thumbwebs
  def self.included(base)
    base.send :extend, ClassMethods
  end

  module ClassMethods
    # any method placed here will apply to classes, like User
    def acts_as_thumbwebs_subscriber
      
      send :include, InstanceMethods
    end
  end

  module InstanceMethods
    # any method placed here will apply to instances, like @user
    def is_thumbwebs_subscriber?
      begin
      Subscriber.find(:all, :params => {:email => self.email,
                                        :channel_id  => THUMBWEBS_CHANNEL_ID,
                                      #     :channel_id => 1,
                                           :uid => self.id})
      #Subscriber.find(uid)
      rescue ActiveResource::ResourceNotFound
        return false
      end  
   end  
  
  end
end
