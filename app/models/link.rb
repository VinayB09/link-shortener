class Link < ApplicationRecord
	validates_presence_of :url
  validates :url, format: URI::regexp(%w[http https])
  validates_uniqueness_of :slug
  # validates_length_of :url, within: 3..255, on: :create, message: "too long"
  # validates_length_of :slug, within: 3..255, on: :create, message: "too long"

  def self.shorten(url, slug = '')
  	# return short when URL with that slug was created before
	  link = Link.where(url: url, active: true).first
	  return link.id if link 
	    
	  # create a new
	  slug = SecureRandom.urlsafe_base64(3)
	  link = Link.new(url: url, slug: slug)
	  return link.id if link.save
	end

	def short
	  return "s/#{slug}"
	end

	def make_expired
		self.active = false
		self.save!
	end
end
