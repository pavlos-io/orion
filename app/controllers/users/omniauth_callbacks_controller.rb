class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_filter :verify_authenticity_token, :only => :steam

  def steam
    auth = request.env["omniauth.auth"]
    steam_name = auth.info['nickname'].downcase

    # raise auth.to_yaml

    # Try to find user_token first
    utoken = UserToken.find_by_provider_and_uid(auth['provider'], auth['uid'])
    if utoken
      # Authentication found, update user_tokeb and sign in.
      utoken.update_omniauth(auth)
      utoken.user.update_user_omniauth(auth) # important to update also the twitter_name
      
      if utoken.save(validate: false)
        sign_in utoken.user
        flash[:good] = "found & signed in"
        redirect_to root_path
      else
        failure
      end
    else
      # Authentication not found, thus a new user.
        user = User.new
        user.apply_omniauth(auth)

        if user.save(validate: false)
          sign_in user
          flash[:good] = "signed in"
          redirect_to root_path
        else
          flash[:error] = "Error while creating a user account. Please try again."
          redirect_to new_user_session_path
        end

    end
    # user = { :nickname => auth.info['nickname'],
    #          :image    => auth.info['image'],
    #          :uid      => auth.uid
    #        }
  end


  def twitter
    auth = request.env["omniauth.auth"]
    twitter_name = auth['info']['nickname'].downcase

    # Try to find user_token first
    utoken = UserToken.find_by_provider_and_uid(auth['provider'], auth['uid'])
    if utoken
      # Authentication found, update user_tokeb and sign in.
      utoken.update_omniauth(auth)
      utoken.user.update_user_omniauth(auth) # important to update also the twitter_name
      
      if utoken.save(validate: false)
        sign_in utoken.user
        redirect_to root_path
      else
        failure
      end
    else
      # Authentication not found, thus a new user.
      allowed_user = AllowedUser.find_by_twitter_name(twitter_name) #search for the twitter name in the 'allowed users' table

      if allowed_user
        user = User.new
        user.allowed_user_id = allowed_user.id #has_one relationship hook
        user.apply_omniauth(auth)

        if user.save(validate: false)
          sign_in user
          redirect_to root_path
        else
          flash[:error] = "Error while creating a user account. Please try again."
          redirect_to new_user_session_path
        end
      else
        flash[:error] = "You are not allowed to sign in"
        redirect_to new_user_session_path
      end
    end

  end

  def failure
    redirect_to new_user_session_path, alert: "Authentication failed, please try again."
  end
end
