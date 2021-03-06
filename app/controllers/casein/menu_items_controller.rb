# Scaffolding generated by Casein v5.1.1.5

module Casein
  class MenuItemsController < Casein::CaseinController
  
    ## optional filters for defining usage according to Casein::AdminUser access_levels
    # before_filter :needs_admin, :except => [:action1, :action2]
    # before_filter :needs_admin_or_current_user, :only => [:action1, :action2]
  
    def index
      @casein_page_title = 'Site Menu'
  		@menu_items = MenuItem.order(:position).paginate :page => params[:page]
    end
  
    def show
      @casein_page_title = 'View menu item'
      @menu_item = MenuItem.find params[:id]
    end
  
    def new
      @casein_page_title = 'Add a new menu item'
    	@menu_item = MenuItem.new
    end

    def create
      @menu_item = MenuItem.new menu_item_params
    
      if @menu_item.save
        flash[:notice] = 'Menu item created'
        redirect_to casein_menu_items_path
      else
        flash.now[:warning] = 'There were problems when trying to create a new menu item'
        render :action => :new
      end
    end
  
    def update
      @casein_page_title = 'Update menu item'
      
      @menu_item = MenuItem.find params[:id]
    
      if @menu_item.update_attributes menu_item_params
        flash[:notice] = 'Menu item has been updated'
        redirect_to casein_menu_items_path
      else
        flash.now[:warning] = 'There were problems when trying to update this menu item'
        render :action => :show
      end
    end
    
    def move
      @menu_item = MenuItem.find params[:id]
      
      case params[:direction]
      when "up"
        @menu_item.move_higher
      when "down"
        @menu_item.move_lower
      when "top"
        @menu_item.move_to_top
      when "bottom"
        @menu_item.move_to_bottom
      end
      
      redirect_to casein_menu_items_path
    end
 
    def destroy
      @menu_item = MenuItem.find params[:id]

      @menu_item.destroy
      flash[:notice] = 'Menu item has been deleted'
      redirect_to casein_menu_items_path
    end
  
    private
      
      def menu_item_params
        params.require(:menu_item).permit(:position, :page_id)
      end

  end
end