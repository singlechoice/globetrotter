class CheckpointsController < ApplicationController
  before_filter :authorize
  # GET /checkpoints
  # GET /checkpoints.xml
  def index
    @checkpoints = Checkpoint.find_all_by_user_id params[:user_id]
    @user = User.find params[:user_id]
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @checkpoints }
    end
  end

  # GET /checkpoints/1
  # GET /checkpoints/1.xml
  def show
    @checkpoint = Checkpoint.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @checkpoint }
    end
  end

  # GET /checkpoints/new
  # GET /checkpoints/new.xml
  def new
    @checkpoint = Checkpoint.new
    @checkpoint.user = current_user
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @checkpoint }
    end
  end

  # GET /checkpoints/1/edit
  def edit
    @checkpoint = Checkpoint.find(params[:id])
  end

  # POST /checkpoints
  # POST /checkpoints.xml
  def create
    @checkpoint = Checkpoint.new(params[:checkpoint])
    @checkpoint.user = current_user
    respond_to do |format|
      if @checkpoint.save
        format.html { redirect_to(user_checkpoints_url(@checkpoint.user), :notice => 'Checkpoint was successfully created.') }
        format.xml  { render :xml => @checkpoint, :status => :created, :location => @checkpoint }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @checkpoint.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /checkpoints/1
  # PUT /checkpoints/1.xml
  def update
    @checkpoint = Checkpoint.find(params[:id])
    @checkpoint.user = current_user
    respond_to do |format|
      if @checkpoint.update_attributes(params[:checkpoint])
        format.html { redirect_to([@checkpoint.user, @checkpoint], :notice => 'Checkpoint was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @checkpoint.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /checkpoints/1
  # DELETE /checkpoints/1.xml
  def destroy
    @checkpoint = Checkpoint.find(params[:id])
    if @checkpoint.user == current_user
      flash[:notice] = "This is not your checkpoint"
    else
      @checkpoint.destroy      
    end
    respond_to do |format|
      format.html { redirect_to(checkpoints_url) }
      format.xml  { head :ok }
    end
  end
end
