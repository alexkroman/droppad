class ChannelController < ApplicationController
  layout 'general'  
  before_filter :login_required, :except => [ :login, :index, :create ]

  def index
    if request.post?
      @channel = Channel.new(params[:channel])
      if @channel.save
        session[@channel.identifier] = true
        email = IdeaMailer.create_welcome(@channel.email, @channel)
        IdeaMailer.deliver(email)
        redirect_to :action => 'visit', :id => @channel.identifier
      end
    end
  end
  
  def top
    @channel = Channel.find_by_identifier(params[:id])
  end

  def login
    if request.post?
        channel = Channel.find_by_identifier(params[:id])
        if Channel.authenticate?(channel.identifier, params[:channel][:password])
          session[channel.identifier] = true
          redirect_to :action => 'visit', :id => channel.identifier
        end
    end
  end
  
  def rate
    message = Message.find(params[:id])
    message.rate(cookies[:_session_id])
    render :nothing => true
  end
  
  def logout
    reset_session
    redirect_to :controller => '/'
  end
  
  def remove_rating
    @rating = Rating.delete_all(["session_id = ? and message_id = ?", cookies[:_session_id], params[:id]])
    render :nothing => true
  end
 
  def visit
    @channel = Channel.find_by_identifier(params[:id])
    @ratings_hash = get_ratings_hash
  end

  def rss
    @channel = Channel.find_by_identifier(params[:id])
    render :action => 'rss', :layout => false   
  end
  
  def send_invitation
    @channel = Channel.find_by_identifier(params[:id])
    @emails = params[:invite][:emails].split(/,/).each do |email|
      email = IdeaMailer.create_invitation(email, params[:invite][:name], @channel)
      IdeaMailer.deliver(email)
    end
    render :nothing => true
  end
  
  def say
    @channel = Channel.find_by_identifier(params[:id])
    @message = Message.new(:channel => @channel, :content => params[:talk][:message], :session_id => cookies[:_session_id])
    @message.save
    render :nothing => true
  end

  def get_latest_messages
    @channel = Channel.find_by_identifier(params[:id])
    @messages = @channel.messages.since(session[:last_retrieval], cookies[:_session_id])
    session[:last_retrieval] = Time.now
    @ratings_hash = Hash.new
    render :partial => 'latest_messages'    
  end

  protected
  
  def get_ratings_hash
    ratings_hash = Hash.new
    ratings = Rating.find_all_by_session_id(cookies[:_session_id]).each { |rating|
      ratings_hash[rating.message_id] = rating.created_at
    }
    ratings_hash
  end
  
end
