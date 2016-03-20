# == Schema Information
#
# Table name: users
#
#  id                      :integer          not null, primary key
#  email                   :string           default(""), not null
#  encrypted_password      :string           default(""), not null
#  reset_password_token    :string
#  reset_password_sent_at  :datetime
#  remember_created_at     :datetime
#  sign_in_count           :integer          default(0), not null
#  current_sign_in_at      :datetime
#  last_sign_in_at         :datetime
#  current_sign_in_ip      :string
#  last_sign_in_ip         :string
#  created_at              :datetime
#  updated_at              :datetime
#  provider                :string
#  uid                     :string
#  image                   :text
#  name                    :string
#  spotify_hash            :text
#  spotify_id              :string
#  chartgeneratecount      :integer          default(0)
#  chartgeneratetime       :datetime
#  about                   :text
#  rank                    :string
#  last_download_playlists :datetime
#

FactoryGirl.define do
  factory :user do
  	sequence(:provider) { |n| "123456" + "#{n}"}
		sequence(:uid) { |n| "123451" + "#{n}"}
		sequence(:name) { |n| "User-#{n}"}
		sequence(:email) { |n| "User-#{n}@example.com"}
		password "12345678"
  end
end
