module Omniauth

  module Mock
    def auth_mock
      OmniAuth.config.mock_auth[:spotify] = {
        'provider' => 'spotify',
        'uid' => '123545',
        'info'=>
          {
            'country'=>'GB',
            'display_name'=>'Mario Poli',
            'email'=>'mariopoli@google.com',
            'external_urls'=>{'spotify'=>'https://open.spotify.com/user/mariopoli'}
          },
        'credentials' => 
          {
            'token' => 'xxxx',
            'refresh_token' => 'xxxx',
            'expires_at' => Time.now + 1.week,
            'expires' => true
          },
        'extra' =>
          {
            'raw_info'=>
              {
                'country'=>'GB',
                'display_name'=>'Mario Poli',
                'email'=>'mariopoli@google.com',
                'external_urls'=>{'spotify'=>'https://open.spotify.com/user/mariopoli'},
                'followers'=>{'href'=>nil, 'total'=>0},
                'href'=>'https://api.spotify.com/v1/users/mariopoli',
                'id'=>'mariopoli',
                'images'=>
                  [{'height'=>nil,
                    'url'=>
                    'https://fbcdn-profile-a.akamaihd.net/hprofile-ak-xfp1/t1.0-1/s320x320/301234_1962753760624_625151598_n.jpg',
                    'width'=>nil
                  }],
                'product'=>'open',
                'type'=>'user',
                'uri'=>'spotify:user:mariopoli'
              }
          }
      }
    end
  end

  module SessionHelpers
    def signin
      visit root_path
      expect(page).to have_content("CONNECT WITH SPOTIFY")
      auth_mock
      click_link "CONNECT WITH SPOTIFY", match: :first
    end
  end
  
end

