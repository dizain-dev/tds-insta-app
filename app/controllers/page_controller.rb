class PageController < ApplicationController
	before_action :set_calback_url, :only => [:connect, :connect_callback]
	def index
	end
	def connect
	  if params[:tag_choice].present?	
	  	session[:tag] = params[:tag_choice]
	  	redirect_to Instagram.authorize_url(:redirect_uri => callback_url, :scope => 'public_content')
	  else
	  	flash[:error] = "Voce tm que preencher"
	  	redirect_to '/'	
	  end	
	end
	def connect_callback
		response = Instagram.get_access_token(params[:code], :redirect_uri => callback_url)
  		session[:access_token] = response.access_token
  		redirect_to action: "taginfo"
	end
	def taginfo
	 	@tag_searched = if params[:new_tag].present? then params[:new_tag] else session[:tag] end
	 	client = Instagram.client(:access_token => session[:access_token])
		@medias = client.tag_recent_media( @tag_searched, count: 200)
	 	render "tags"	
	end
	private
	def set_calback_url
		callback_url = "http://localhost:3000/callback"
	end
end
