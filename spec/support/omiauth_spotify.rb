module OmniauthSpotify
  def mock_auth_hash
    # The mock_auth configuration allows you to set per-provider (or default)
    # authentication hashes to return during integration testing.
    OmniAuth.config.mock_auth[:twitter] = {
       'provider' => 'spotify',
			  'uid' => '1111111111',
			  'info' => {
			    'name' => 'Claudio Poli',
			    'nickname' => 'SomeName',
			    'email' => 'claudio@icorete.ch',
			    'urls' => {'spotify' => 'https://open.spotify.com/user/1111111111'},
			    'image' => 'https://fbcdn-profile-a.akamaihd.net/hprofile-ak-xfp1/t1.0-1/s320x320/301234_1962753760624_625151598_n.jpg'

			  },
			  'credentials' => {
			    'token' => 'xxxx',
			    'refresh_token' => 'xxxx',
			    'expires_at' => 1403021232,
			    'expires' => true
			  },
			  'extra' => {
			    'raw_info' => {
			      'country' => 'IT',
			      'display_name' => 'Claudio Poli',
			      'email' => 'claudio@icorete.ch',
			      'external_urls' => {
			        'spotify' => 'https://open.spotify.com/user/1111111111'
			      },
			      'href' => 'https://api.spotify.com/v1/users/1111111111',
			      'id' => '1111111111',
			      'images' => [
			        {
			          'height' => nil,
			          'url' => 'https://fbcdn-profile-a.akamaihd.net/hprofile-ak-xfp1/t1.0-1/s320x320/301234_1962753760624_625151598_n.jpg',
			          'width' => nil
			        }
			      ],
			      'product' => 'open',
			      'type' => 'user',
			      'uri' => 'spotify:user:1111111111'
			    }
			  }
    }
  end
end