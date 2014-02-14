require 'spec_helper'

describe User do
    it "can't login with new user" do
        User.login('newuser', 'fakepassword').should == -1
    end
    it "can't create user with no name" do
        User.add('', 'fakepassword').should == -3
    end
    it "can't create user with too long name" do
        User.add('long'*100, 'fakepassword').should == -3
    end
    it "can't create user with too long password" do
        User.add('fakename', 'fakepassword'*50).should == -4
    end
    it "can add a new user" do
        User.add('usersuccess','pass').should == 1
    end
    it "can login an existing user" do
        User.add('hey','pass')
        User.login('hey','pass').should == 2
    end
    it "can't login with wrong password" do
        User.add('lol','passwrong')
        User.login('lol','pass').should == -1
    end
    it "can't add existing user" do
         User.add('usersuccess1','pass')
         User.add('usersuccess1','pass').should == -2
    end
    it "should increment logins" do
        User.add('usersuccess3','pass')
        User.login('usersuccess3','pass')
        User.login('usersuccess3','pass')
        User.login('usersuccess3','pass')
        User.login('usersuccess3','pass').should == 5
    end
    it "can't create user w/ too long name and password" do
        User.add('fakename'*50, 'fakepassword'*50).should_not == 1
    end
    
    
    
end
