class PagesController < ApplicationController
  def show
    @path_parts = (params[:path] || '/home').split('/').reject(&:empty?)
    
    # Find the page
    collection = Page.roots
    page = nil
    @path_parts.each do |slug|
      page = collection.find_by(slug: slug)
      if page
        collection = page.children
      else
        page = Page.not_found
        break
      end
    end
    
    # If we found a page, but it wasn't published, fall back to /404
    unless page.published?
      page = Page.not_found
    end
    
    if page.published?
      # Extract the body text
      @body = page.body
    else
      # If the page still isn't published, then the custom 404 page is not
      # published.
      @body = Page::FALLBACK_PAGE_BODY
    end
    
    # Walk up the page hierarchy until we find a sidebar
    while page
      if page.published?
        @sidebar = page.sidebar
      end
      
      break if @sidebar.present?
      
      page = page.parent
    end
    
    # If we still don't have a sidebar, grab the one from /home
    unless @sidebar.present?
      @sidebar = Page.home.sidebar
    end
    
    # Ensure that we can display both the body and sidebar
    @body = @body.to_s.html_safe
    @sidebar = @sidebar.to_s.html_safe
    
    @menu_items = MenuItem.all
  end
end
