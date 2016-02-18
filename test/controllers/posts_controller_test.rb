require 'test_helper'

class PostsControllerTest < ActionController::TestCase
  setup do
    @post = posts(:one)
    @topic = topics(:one)
    @forum = forums(:one)
    
  end

end
