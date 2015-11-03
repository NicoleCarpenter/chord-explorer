class TabsController < ApplicationController
  before_action :set_tab, only: [:show, :edit, :update, :destroy]
  respond_to :html, :js, :json
  # GET /tabs
  # GET /tabs.json
  def index
    if request.xhr?
      puts "VIA AJAX"
      @tabs = Tab.search(params)
      p @tabs.keys
      @tabs_keys = @tabs.keys
      p "****************************************************************"
      p @tabs_keys
      p "*****************************************************************"
      p @tabs
      p params
      @tabs_keys_pages = @tabs_keys.paginate(:page => params[:page] || 1)
    else
      @tabs = Tab.all
    end
  end

  # GET /tabs/1
  # GET /tabs/1.json
  def show
  end

  # GET /tabs/new
  def new
    @tab = Tab.new
  end

  # GET /tabs/1/edit
  def edit
  end

  # POST /tabs
  # POST /tabs.json
  def create
    @tab = Tab.new(tab_params)

    respond_to do |format|
      if @tab.save
        format.html { redirect_to @tab, notice: 'Tab was successfully created.' }
        format.json { render :show, status: :created, location: @tab }
      else
        format.html { render :new }
        format.json { render json: @tab.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tabs/1
  # PATCH/PUT /tabs/1.json
  def update
    respond_to do |format|
      if @tab.update(tab_params)
        format.html { redirect_to @tab, notice: 'Tab was successfully updated.' }
        format.json { render :show, status: :ok, location: @tab }
      else
        format.html { render :edit }
        format.json { render json: @tab.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tabs/1
  # DELETE /tabs/1.json
  def destroy
    @tab.destroy
    respond_to do |format|
      format.html { redirect_to tabs_url, notice: 'Tab was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tab
      @tab = Tab.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tab_params
      params.require(:tab).permit(:url, :rating, :click_count, :raw_html, :song_id)
    end
end
