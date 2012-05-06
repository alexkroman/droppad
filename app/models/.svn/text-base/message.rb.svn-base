class Message < ActiveRecord::Base
  belongs_to :channel, :counter_cache => true 
  has_many :ratings
  validates_length_of :content, :in => 1..1000
  validates_presence_of :session_id
  validates_numericality_of :channel_id, :only_integer => true
  after_create :rate
  
  def self.top
    find(:all, :conditions => ["ratings_count > 0"], :order => 'ratings_count desc', :limit => 10)
  end
  
  def self.since(time, session_id)
    find(:all, :conditions => ['created_at >= ? and session_id != ?', time, session_id])
  end

  def rate(session_id = nil)
    session_id = self.session_id if session_id == nil
    @rating = Rating.new(:message => self, :session_id => session_id)
    @rating.save
  end
  
end
