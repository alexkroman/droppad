# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def message_content(message)
    @message = message
    render :partial => 'message'
  end
  
  def channel_url(channel)
    url_for :only_path => false, :controller => "/channel", :action => "visit", :id => channel.id
  end
  
end
