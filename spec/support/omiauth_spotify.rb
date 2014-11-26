module OmniauthSpotify
  
  def mock_spotify_auth_hash
  	if Rails.env.test?
      OmniAuth.config.test_mode = true
	    OmniAuth.config.mock_auth[:spotify] = 
	    {
			 'provider'=>'spotify',
			 'uid'=>'mariopoli',
			 'info'=>
			  {
			  	'country'=>'GB',
			   	'display_name'=>'Mario Poli',
			   	'email'=>'mariopoli@google.com',
			   	'external_urls'=>{'spotify'=>'https://open.spotify.com/user/mariopoli'
			  },
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
			  'uri'=>'spotify:user:mariopoli'},
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
end
