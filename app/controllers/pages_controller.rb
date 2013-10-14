class PagesController < ApplicationController
  require 'rubygems'
  require 'google/api_client'
  require 'yaml'
  before_filter :authorize_or_redirect, :only => :admin
  before_filter :google

  def admin
    @bodyclass = "admin"
    @title = "Powerbridge :: Administration"
    @metatag = "Administration homepage for Powerbridge"
    @users = User.all
  end
  
  def dashboard
    if ["judge", "mentor", "advisor", "team member"].include?(current_user.blank? ? "" : current_user.label)
    
    else
      redirect_to root_path, notice: "Not authorized"
    end
  end
  
  def index
    client = Twitter::Client.new(
      :consumer_key => "v5cx7jj0DeyqGmbemMZ2Q",
      :consumer_secret => "GNYBvWvsmK0Pa90Om91bkSiFHHgYqzaaQkmtUvJtca8",
      :oauth_token => "1245456781-xstWTBf9nntOoHMxKfYh9znCg7xKWgGa2VU0aAX",
      :oauth_token_secret => "Et09WWU3xHR7IVVgdqtgMY8iFIhCneZslGsN1llmTfE"
    )
    @tweets = client.user_timeline("powerbridgeny", :count => 3)
    @post = Post.where("active=?", true).last
  end
  
  def about
    @pbabout = AboutSection.where("section=? and active=?", "powerbridge", true)
    @inabout1 = AboutSection.where("section=? and active=? and col_number=?", "institution", true, "1").order("title asc")
    @inabout2 = AboutSection.where("section=? and active=? and col_number=?", "institution", true, "2").order("title asc")
    @questions = Question.find(:all, :order => "row_order asc")
    @judges = Judge.find(:all, :order => "name asc")
    @mentors = Mentor.find(:all, :order => "name asc")
  end
  
  def faq
    @questions = Question.all
  end
  def accept_answer
    @question = Question.find(params[:question])
    @question.update_attribute("answered", true)
    @answer = Answer.find(params[:answer])
    @answer.update_attribute("accepted", true)
  end
  
  def news
    @news = Post.where("active=?", true).order("created_at desc")
    @post = @news.first
    @cnews = Post.where("section=? and active=?", "cleantech", true)
    @anews = Post.where("section=? and active=?", "awardees", true)
      #client = Twitter::REST::Client.new do |config|
      #  config.consumer_key        = "v5cx7jj0DeyqGmbemMZ2Q"
      #  config.consumer_secret     = "GNYBvWvsmK0Pa90Om91bkSiFHHgYqzaaQkmtUvJtca8"
      #  config.access_token        = "1245456781-xstWTBf9nntOoHMxKfYh9znCg7xKWgGa2VU0aAX"
      #  config.access_token_secret = "Et09WWU3xHR7IVVgdqtgMY8iFIhCneZslGsN1llmTfE"
      #end
    client = Twitter::Client.new(
      :consumer_key => "v5cx7jj0DeyqGmbemMZ2Q",
      :consumer_secret => "GNYBvWvsmK0Pa90Om91bkSiFHHgYqzaaQkmtUvJtca8",
      :oauth_token => "1245456781-xstWTBf9nntOoHMxKfYh9znCg7xKWgGa2VU0aAX",
      :oauth_token_secret => "Et09WWU3xHR7IVVgdqtgMY8iFIhCneZslGsN1llmTfE"
    )
    @tweets = client.user_timeline("powerbridgeny", :count => 5)
  end
  def article
    @post = Post.find(params[:id])
    @news = Post.where("active=? and id !=?", true, @post.id).order("created_at desc")
    @cnews = Post.where("section=? and active=?", "cleantech", true)
    @anews = Post.where("section=? and active=?", "awardees", true)
      #client = Twitter::REST::Client.new do |config|
      #  config.consumer_key        = "v5cx7jj0DeyqGmbemMZ2Q"
      #  config.consumer_secret     = "GNYBvWvsmK0Pa90Om91bkSiFHHgYqzaaQkmtUvJtca8"
      #  config.access_token        = "1245456781-xstWTBf9nntOoHMxKfYh9znCg7xKWgGa2VU0aAX"
      #  config.access_token_secret = "Et09WWU3xHR7IVVgdqtgMY8iFIhCneZslGsN1llmTfE"
      #end
    client = Twitter::Client.new(
      :consumer_key => "v5cx7jj0DeyqGmbemMZ2Q",
      :consumer_secret => "GNYBvWvsmK0Pa90Om91bkSiFHHgYqzaaQkmtUvJtca8",
      :oauth_token => "1245456781-xstWTBf9nntOoHMxKfYh9znCg7xKWgGa2VU0aAX",
      :oauth_token_secret => "Et09WWU3xHR7IVVgdqtgMY8iFIhCneZslGsN1llmTfE"
    )
    @tweets = client.user_timeline("powerbridgeny", :count => 5)
  end
  
  def contact
    @emails = Contact.all
    @message = Message.new
    @newsletter = Subscription.new
  end
  
  def send_mail
  	@message = Message.new(params[:message])
  	email = params[:email]
  	subject = params[:subject]
  	sender = params[:from]
  	SendMail.email(sender, email, subject, @message).deliver
  	redirect_to "/contact", :notice => "Email was delivered"
  end
  
  def external_auth
    @auth = request.env["omniauth.auth"]
    current_user.update_attributes(:google_access_token => @auth["credentials"]["token"], :google_refresh_token => @auth["credentials"]["refresh_token"], :google_expires_at => @auth["credentials"]["expires_at"])
    redirect_to session[:originating_url] || root_path
  end
  def calendar
    @events = @google_events + Event.all
    guser = User.find(1)
    token = guser.google_access_token
    rtoken = guser.google_refresh_token
    @future_events = []
    unless token.blank?
      oauth_yaml = YAML.load_file('google-api.yaml')
      client = Google::APIClient.new
      client.authorization.client_id = oauth_yaml["client_id"]
      client.authorization.client_secret = oauth_yaml["client_secret"]
      client.authorization.scope = oauth_yaml["scope"]
      client.authorization.refresh_token = rtoken
      client.authorization.access_token = token
      
      if client.authorization.refresh_token && client.authorization.expired?
        client.authorization.fetch_access_token!
      end
      
      service = client.discovered_api('calendar', 'v3')
      result = client.execute(
        :api_method => service.events.list,
        #:parameters => {'calendarId' => 'primary', "timeMin" => Time.now.xmlschema},
        :parameters => {'calendarId' => 'primary', 'singleEvents' => true, 'orderBy' => 'startTime', "timeMin" => Time.now.xmlschema},
        :headers => {'Content-Type' => 'application/json'}
      )
      items = JSON.parse(result.data.to_json)["items"]
      items.each do |i|
        unless i["start"].blank?
          hash = {"id" => i["id"], "start_time" => i["start"]["date"].blank? ? i["start"]["dateTime"] : i["start"]["date"], "end_time" => i["end"]["date"].blank? ? i["end"]["dateTime"] : i["end"]["date"], "name" => i["summary"], "description" => i["description"], "location" => i["location"]}
          s = OpenStruct.new hash
          @future_events.push(s)
        end
      end
    end
    list = Event.where("event_date>?", Time.now) + @future_events
    @listevents = list.sort_by{|e| Date.parse(e.start_time)}
  end
  
  def application
  end
  
  def google
    guser = User.find(1)
    token = guser.google_access_token
    rtoken = guser.google_refresh_token
    @google_events = []
    if Event.all.empty?
      @footer_events = []
    else
      @footer_events = Event.find(:all, :conditions => ["in_footer=?", true], :order => "event_date asc", :limit => 4)
    end
    unless token.blank?
      oauth_yaml = YAML.load_file('google-api.yaml')
      client = Google::APIClient.new
      client.authorization.client_id = oauth_yaml["client_id"]
      client.authorization.client_secret = oauth_yaml["client_secret"]
      client.authorization.scope = oauth_yaml["scope"]
      client.authorization.refresh_token = rtoken
      client.authorization.access_token = token
      
      if client.authorization.refresh_token && client.authorization.expired?
        client.authorization.fetch_access_token!
      end
      
      service = client.discovered_api('calendar', 'v3')
      result = client.execute(
        :api_method => service.events.list,
        #:parameters => {'calendarId' => 'primary', "timeMin" => Time.now.xmlschema},
        :parameters => {'calendarId' => 'primary', 'singleEvents' => true, 'orderBy' => 'startTime'},
        :headers => {'Content-Type' => 'application/json'}
      )
  
      items = JSON.parse(result.data.to_json)["items"]
      
      items.each do |i|
        unless i["start"].blank?
          hash = {"id" => i["id"], "start_time" => i["start"]["date"].blank? ? i["start"]["dateTime"] : i["start"]["date"], "end_time" => i["end"]["date"].blank? ? i["end"]["dateTime"] : i["end"]["date"], "name" => i["summary"], "description" => i["description"], "location" => i["location"]}
          s = OpenStruct.new hash
          @google_events.push(s)
        end
      end
      
      if Event.all.empty?
        foot = client.execute(
          :api_method => service.events.list,
          #:parameters => {'calendarId' => 'primary', "timeMin" => Time.now.xmlschema},
          :parameters => {'calendarId' => 'primary', 'singleEvents' => true, 'orderBy' => 'startTime', "timeMin" => Time.now.xmlschema},
          :headers => {'Content-Type' => 'application/json'}
        )
    
        footer = JSON.parse(foot.data.to_json)["items"]
        
        footer.each do |i|
          unless i["start"].blank?
            hash = {"id" => i["id"], "start_time" => i["start"]["date"].blank? ? i["start"]["dateTime"] : i["start"]["date"], "end_time" => i["end"]["date"].blank? ? i["end"]["dateTime"] : i["end"]["date"], "name" => i["summary"], "description" => i["description"], "location" => i["location"]}
            s = OpenStruct.new hash
            @footer_events.push(s)
          end
        end
      end
    end
  end
end
