class Resource < ActiveRecord::Base
  belongs_to :user

	validates :title, presence: true
	validates :language, presence: true
	validates :link, presence: true
	  
end
