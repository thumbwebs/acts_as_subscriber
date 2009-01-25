### put rescue_from methods here
module Errors
    
  #do_thumbwebs_rescues
  
def thumbwebs_record_not_found
  flash[:error] = "Record not found"
  redirect_to show_errors_thumbwebs_channels_path
end

def thumbwebs_unauthorized_access
  flash[:error] = "Unauthorized Access"
  redirect_to show_errors_thumbwebs_channels_path
end  

def thumbwebs_time_out_error
  flash[:error] = "Timed Out Error"
  ### TODO stop infinite loop if server is down
  redirect_to show_errors_thumbwebs_channels_path
end  


def do_thumbwebs_rescues
  rescue_from ActiveResource::ResourceNotFound, :with => :thumbwebs_record_not_found #if RAILS_ENV == 'production'
  rescue_from ActiveResource::UnauthorizedAccess, :with => :thumbwebs_unauthorized_access
  rescue_from ActiveResource::TimeoutError, :with => :thumbwebs_time_out_error
end

end