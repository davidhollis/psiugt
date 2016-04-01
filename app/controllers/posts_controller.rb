class PostsController < ApplicationController
  def index
    @posts = Post.published.paginate(page: params[:page]).order('created_at DESC')
    if @home_page.published?
      @head_copy = @home_page.body.to_s.html_safe
    end
  end

  def show
    post = Post.find(params[:id])
    if post&.published?
      @title = post.title
      @body = post.body
      @date = post.created_at.strftime('%F %T %Z')
    else
      @title, @body = page_not_found
    end
    
    # Ensure that we can display the body
    @body = @body.to_s.html_safe
  end
end
