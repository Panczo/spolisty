module Omniauth

  module Mock
    def auth_mock
      OmniAuth.config.mock_auth[:spotify] = 
      {
        "provider"=>"spotify", 
        "uid"=>"testsanczo", 
        "info"=>
          {
            "country"=>"PL",
            "display_name"=>nil,
            "email"=>"testsanczo@gmail.com",
            "external_urls"=>
              {"spotify"=>"https://open.spotify.com/user/testsanczo"},
            "followers"=>{"href"=>nil, "total"=>0}, 
            "href"=>"https://api.spotify.com/v1/users/testsanczo",
            "id"=>"testsanczo",
            "images"=>[], 
            "product"=>"open", 
            "type"=>"user", 
            "uri"=>"spotify:user:testsanczo", 
            "name"=>"testsanczo@gmail.com"
          }, 
        "credentials"=>
          {
            "token"=>"BQColySz79b0dlZ2JoE7IMCEWCeQZRehgnETMar3wlBWriRgDHDJvZ-HvnE_dwTn29cK26tEuBparjFVTNnBqAk_kz5goejtrmGRszlVV1L2Ip6yMLqw8JdggorX6tOnektKdSUrvruxbEtY61Kp_5d9My6cR4ElKNN7UAPWTN8Ktpumxazeo70rvgG9spMTM96bYptTTwi-Eqc_TFSyasD31saLs2cTp7vMsQED0J2-R5kpwWA", "refresh_token"=>"AQA1wCBKvlwEZqDbrKi1Xa76eKpm7EIeBw2wKv9u0Deegx8N60X-wBQIOjUPw8aATCqlr6VQdIxhr0sMxkiuDugdTqbD12mCTU2Gbr2TiLbvw1EPnc7LguZe9xp444kHi4o", 
            "expires_at"=>1421157078, 
            "expires"=>true
          }, 
        "extra"=>
          {
            "raw_info"=>
              {
                "country"=>"PL",
                "display_name"=>nil,
                "email"=>"testsancz@gmail.com",
                "external_urls"=>
                  {"spotify"=>"https://open.spotify.com/user/testsanczo"},
                "followers"=>{"href"=>nil, "total"=>0},
                "href"=>"https://api.spotify.com/v1/users/testsanczo",
                "id"=>"testsanczo", 
                "images"=>[], 
                "product"=>"open", 
                "type"=>"user", 
                "uri"=>"spotify:user:testsanczo"
              }
          }
      }
    end
  end

  module SessionHelpers
    def signin
      visit pages_path
      expect(page).to have_content("CONNECT WITH SPOTIFY")
      @user = auth_mock
      click_link "CONNECT WITH SPOTIFY", match: :first
    end
  end
end

RSpec.configure do |c|
  c.include Omniauth, type: :feature
end