class PagesController < ApplicationController
	include PagesHelper
	def index
		@index = get_index session[:user_id]
	end
end
