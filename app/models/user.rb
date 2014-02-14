class User < ActiveRecord::Base
    
    def self.login(username, password)
        u = User.find_by_name(username)
            if not u
                return -1
            end
        if u.password == password
            u.logins += 1
            u.save!
            return u.logins
        else
            #password wrong
            return -1
        end
    end

    def self.add(username, password)
        if username == ""
            return -3
        elsif username.length >= 129
        #username too long
            return -3
        elsif password.length >= 129
        #password too long
            return -4
        end
        newUser = User.find_by_name(username)
        if newUser
            return -2
        end
        newUser = User.new
        newUser.logins = 1
        newUser.name = username
        newUser.password = password
        newUser.save!
        return 1
    end

end
