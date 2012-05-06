require 'digest/sha1'

class Channel < ActiveRecord::Base
  has_many :messages, :order => 'id asc'
  validates_presence_of :name
  validates_length_of :password, :within => 4..40
  
  validates_each :email do |model, attr, value|
    model.errors.add(attr, "is not valid") unless value.size < 100 && value =~ /.@.+\../ && value.count('@')
  end

  before_create :generate_identifier

  # echo "working this hard will probably kill us" | md5 -
  @@salt = '44e08f4a65b59a6fc28d36d6f2429314'
  cattr_accessor :salt

  def self.authenticate(identifier, password)
    find_first(["identifier = ? AND password = ?", identifier, password])
  end
  
  def self.authenticate?(identifier, password)
    channel = self.authenticate(identifier, password)
    return false if channel.nil?
    return true if channel.id
    
    false
  end
  
  protected

  def self.sha1(password)
    Digest::SHA1.hexdigest("#{salt}--#{password}--")
  end

  def generate_identifier
    write_attribute "identifier", self.class.sha1("#{Time.now()}--#{password}")
  end
  
end
