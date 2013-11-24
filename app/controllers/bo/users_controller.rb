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
      redirect_to [:bo, @user], :notice => I18n.tmsg('successfully_created', :model => I18n.tmodel(User))
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
      redirect_to [:bo, @user], :notice => I18n.tmsg('successfully_updated', :model => I18n.tmodel(User))
    else
      render :action => "edit"
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
   
    redirect_to bo_users_url, :notice => I18n.tmsg('successfully_destroyed', :model => I18n.tmodel(User))
  end
end

