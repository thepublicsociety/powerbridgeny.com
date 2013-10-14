Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, "245366926738-gvoej5lv9r91dftivcrde6tkobjh1soc.apps.googleusercontent.com", "R3a_jz20_Mw7YeHsQqmBclD-", {
    access_type: 'offline',
    scope: 'https://www.googleapis.com/auth/userinfo.email https://www.googleapis.com/auth/calendar',
    redirect_uri:'http://powerbridge.metatroid.com/auth/google_oauth2/callback'
  }
end