class EvaluationsController < ApplicationController
	
	# evaluations
	def index
		
	end
	
	# evaluations/:id
	# evaluations/show/:id
	def show
		if params[:id]
			begin
				@evaluation = Evaluation.find(params[:id])
			rescue
				flash[:error] = "Valutazione non trovata"
			end
		end
	end
	
	# evaluations/show_class/:id
	def show_class
	end
	
	# evaluations/show_user/:id
	def show_user
	end
	
	# evaluations/:id/edit
	# [PUT, PATCH]
	def edit
	end
	
	# evaluations/:id/delete
	# [DELETE, ~GET]
	def delete
	end
	
	# evaluations/new
	# [POST]
	def new
	end
	
	# evaluations/mult
	def mult
	end
end
