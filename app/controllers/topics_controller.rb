class TopicsController < ApplicationController
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

  # GET /topics/1/edit
  def edit
  end

  #Create new topic and then redirects
  def create
    @topic = current_user.topics.build(topic_params)

    respond_to do |format|
      if @topic.save
        format.html { redirect_to @topic, notice: 'topic was successfully created.' }
        format.json { render :show, status: :created, location: @topic }
      else
        format.html { render :new }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /topics/1
  # PATCH/PUT /topics/1.json
  def update
    respond_to do |format|
      if @topic.update(topic_params)
        format.html { redirect_to @topic, notice: 'Topic was successfully updated.' }
        format.json { render :show, status: :ok, location: @topic }
      else
        format.html { render :edit }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /topics/1
  # DELETE /topics/1.json
  def destroy
    @topic.destroy
    respond_to do |format|
      format.html { redirect_to topics_url, notice: 'Topic was successfully destroyed.' }
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

    def find_topic
      @topic = Topic.find(params[:id])
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
