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
    def is_thumbwebs_subscriber?(channel_id = @@thumbwebs_channel_id)
      begin
      Channel_Subscriber.find(:all, :params => {:email => self.email,
                                        :channel_id  => channel_id
                                        :uid => self.id}
      rescue ActiveResource::ResourceNotFound
        return false
      end  
   end  
  
  end
end
