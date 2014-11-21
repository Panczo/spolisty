class Subscribe < ActiveRecord::Base
	validates :email, presence: true

	validates :email, :email_format => { :message => 'incorrect email format'}
end
