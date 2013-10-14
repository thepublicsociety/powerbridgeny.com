class SubscriptionsController < ApplicationController
  before_filter :set_class
  before_filter :authorize_or_redirect, :except => [:create]
  # GET /subscriptions
  # GET /subscriptions.json
  def index
    @subscriptions = Subscription.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @subscriptions }
    end
  end

  # GET /subscriptions/1
  # GET /subscriptions/1.json
  def show
    @subscription = Subscription.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @subscription }
    end
  end

  # GET /subscriptions/new
  # GET /subscriptions/new.json
  def new
    @subscription = Subscription.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @subscription }
    end
  end

  # GET /subscriptions/1/edit
  def edit
    @subscription = Subscription.find(params[:id])
  end

  # POST /subscriptions
  # POST /subscriptions.json
  def create
    @subscription = Subscription.create(params[:subscription])
    groups = params[:subscription][:group_name].split(",").collect(&:strip)
    email = params[:subscription][:email]
    begin
      gb = Gibbon::API.new("f24fdd53217fab0b0698fdaba15c0c6f-us7")
      subscribe = gb.lists.subscribe({
        :id => "caa152eac4",
        :email => {:email => email},
        :merge_vars => {
          :FNAME => "",
          :LNAME => "",
          :groupings => {
            0 => {
              :id => 4457,
              :groups => groups
            }
          }
        },
        :update_existing => true,
        :double_optin => false
      })
      #logger.debug subscribe
    rescue Gibbon::MailChimpError
    
    end
    redirect_to "/contact"
  end

  # PUT /subscriptions/1
  # PUT /subscriptions/1.json
  def update
    @subscription = Subscription.find(params[:id])

    respond_to do |format|
      if @subscription.update_attributes(params[:subscription])
        format.html { redirect_to @subscription, notice: 'Subscription was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @subscription.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /subscriptions/1
  # DELETE /subscriptions/1.json
  def destroy
    @subscription = Subscription.find(params[:id])
    @subscription.destroy

    respond_to do |format|
      format.html { redirect_to subscriptions_url }
      format.json { head :no_content }
    end
  end
  
  private
  
  def set_class
    @bodyclass = "admin admin-page"
  end
end
