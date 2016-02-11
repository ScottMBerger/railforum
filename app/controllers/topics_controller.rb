class TopicsController < ApplicationController
  before_action :find_forum
  before_action :find_topic,  only: [:show, :edit, :update, :destroy]
  before_action :signedin,  except: [:index, :show]
  before_action :admin_or_correct_topic, only: [:update, :edit]
  before_action :admin_user, only: [:destroy]
  
  #Lists all topics
  def index
    @topic = Topic.all
  end

  #Shows all specified topics
  def show
  end

  #New topic page
  def new
    @topic = current_user.topics.build
  end

  def edit
  end

  #Create new topic and then redirects
  def create
    @topic = current_user.topics.build(topic_params)
    @topic.forum_id = params[:forum_id]
    
    if @topic.save
      redirect_to forum_topic_path(@forum, @topic)
    else
      render 'new'
    end
  end

  
  # PATCH/PUT /topics/1
  # PATCH/PUT /topics/1.json
  def update
    if @topic.update_attributes(topic_params)
      flash[:success] = "Topic updated"
      redirect_to forum_topic_path(@forum, @topic)
    else
      render 'edit'
    end
  end

  # DELETE /topics/1
  # DELETE /topics/1.json
  def destroy
    @topic.destroy
    respond_to do |format|
      format.html { redirect_to forum_topics_path, notice: 'Topic was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_topic
      @topic = Topic.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def topic_params
      params.require(:topic).permit(:name, :content)
    end

    def post_params
      params.require(:post).permit(:content, :picture)
    end

    def find_forum
      @forum = Forum.find(params[:forum_id])
    end
    
    def find_topic
      @topic = @forum.topics.find(params[:id])
    end

    
    def correct_user
      @post = current_user.posts.find_by(id: params[:id])
      redirect_to root_url if @post.nil?
    end
    
    def correct_user_topic
      @topic = current_user.topics.find_by(id: params[:id])
      @topic.nil? == false
    end
    
    def admin_or_correct_topic
      redirect_to(root_url) unless current_user.admin? or correct_user_topic
    end
end
