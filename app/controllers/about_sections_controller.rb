class AboutSectionsController < ApplicationController
  before_filter :set_class, :authorize_or_redirect
  # GET /about_sections
  # GET /about_sections.json
  def index
    @about_sections = AboutSection.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @about_sections }
    end
  end

  # GET /about_sections/1
  # GET /about_sections/1.json
  def show
    @about_section = AboutSection.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @about_section }
    end
  end

  # GET /about_sections/new
  # GET /about_sections/new.json
  def new
    @about_section = AboutSection.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @about_section }
    end
  end

  # GET /about_sections/1/edit
  def edit
    @about_section = AboutSection.find(params[:id])
  end

  # POST /about_sections
  # POST /about_sections.json
  def create
    @about_section = AboutSection.new(params[:about_section])

    respond_to do |format|
      if @about_section.save
        format.html { redirect_to about_sections_path, notice: 'About section was successfully created.' }
        format.json { render json: @about_section, status: :created, location: @about_section }
      else
        format.html { render action: "new" }
        format.json { render json: @about_section.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /about_sections/1
  # PUT /about_sections/1.json
  def update
    @about_section = AboutSection.find(params[:id])

    respond_to do |format|
      if @about_section.update_attributes(params[:about_section])
        format.html { redirect_to about_sections_path, notice: 'About section was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @about_section.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /about_sections/1
  # DELETE /about_sections/1.json
  def destroy
    @about_section = AboutSection.find(params[:id])
    @about_section.destroy

    respond_to do |format|
      format.html { redirect_to about_sections_url }
      format.json { head :no_content }
    end
  end
  
  private
  
  def set_class
    @bodyclass = "admin admin-page"
  end
end
