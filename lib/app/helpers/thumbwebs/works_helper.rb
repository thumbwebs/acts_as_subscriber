module Thumbwebs::WorksHelper
  def play_link(media_item, work)
    if work.rights == 'public'
          link_to("Public: #{work.link_text}", play_thumbwebs_channel_work_path(:id => work.id, :channel_id => work.channel_id, :media_item_id => media_item.id))
    
    elsif work.rights == 'channel_licensed'
       link_to("Licensed: #{work.link_text}", play_thumbwebs_channel_work_path(:id => work.id, :channel_id => work.channel_id, :media_item_id => media_item.id))
    
    end
 end
  
end
 