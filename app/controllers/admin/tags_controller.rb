class Admin::TagsController < Admin::BaseController
  before_filter :find_tag, :except => 'index'

  def index
    @tags = Tag.paginate(:order => 'name', :page => params[:page])
  end

  def show
  end

  def edit
  end

  def update
    if @tag.update_attributes(params[:tag])
      flash[:notice] = "Tag updated"
      redirect_to :action => 'index'
    else
      render :action => 'edit'
    end
  end

  def destroy
    @tag.taggings.destroy_all
    @tag.destroy

  end

  protected

  def find_tag
    @tag = Tag.find(params[:id])
    redirect_to "/admin/tags", :notice => "delete successful"
  end
end
