class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :find_topic
  before_action :find_post, only: [:edit, :update, :destroy]
  before_action :admin_or_correct_post, only: [:update, :edit]
  before_action :signedin,  except: [:index, :show]
  before_action :admin_user, only: [:destroy]

  def index
    @posts = Post.all
  end

  def show
  end

  def new
    @post = @topic.posts.create(post_params)
  end

  def edit
  end

  def create
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.create(post_params)
    @post.user_id = current_user.id
    
    if @post.save
      redirect_to topic_path(@topic)
    else
      render 'new'
    end
  end

  def update
    if @post.update(post_params)
      redirect_to topic_path(@topic)
    else
      render "edit"
    end
  end


  def destroy
    @post.destroy
    redirect_to topic_path(@topic)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:content)
    end
    
    def find_topic
      @topic = Topic.find(params[:topic_id])
    end
    
    def find_post
      @post = @topic.posts.find(params[:id])
    end
    
    def correct_user_post
      @post = current_user.posts.find_by(id: params[:id])
      @post.nil? == false
    end
    
    def admin_or_correct_post
      redirect_to(root_url) unless current_user.admin? or correct_user_post
    end
end
