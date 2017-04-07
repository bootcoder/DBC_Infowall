a = User.new(username: 'hunter')
a.password = 'hunter'
a.save

t = Token.create(access_token: ENV["SEED_ACCESS_TOKEN"],
                 refresh_token: ENV["SEED_REFRESH_TOKEN"],
                 expires_at: "Fri, 05 Aug 2016 01:38:43 +0000")
