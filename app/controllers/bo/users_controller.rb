class Bo::UsersController < Bo::BaseController
  def index
    @users = User.paginate(:page => params[:page], :per_page => ELEMS_PER_PAGE)
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
   
    if @user.save
      redirect_to([:bo, @user], :notice => 'User was successfully created.') 
    else
      render :action => "new" 
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
   
    if @user.update_attributes(params[:user])
      redirect_to([:bo, @user], :notice => 'User was successfully updated.')
    else
      render :action => "edit"
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
   
    respond_to do |format|
      format.html { redirect_to bo_users_url }
    end
  end
end

