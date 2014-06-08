class EvaluationsController < ApplicationController
	
	filter_before :validate_id, :only => [ :show, :show_class, :show_user, :edit, :delete ]
	
	# evaluations
	def index		
	end
	
	# evaluations/:id
	# evaluations/show/:id
	def show
		begin
			@evaluation = Evaluation.find(params[:id])
		rescue
			flash[:error] = "Valutazione non trovata"
		end
	end
	
	# evaluations/show_class/:id
	def show_class
		# TODO process the class id
	end
	
	# evaluations/show_user/:id
	def show_user
		# TODO process the user id
	end
	
	# evaluations/:id/edit
	# [PUT, PATCH]
	def edit
		# TODO process the edit request... put? get? ecc...
	end
	
	# evaluations/:id/delete
	# [DELETE, ~GET]
	def delete
		# TODO process the delete request
	end
	
	# evaluations/new
	# [POST]
	def new
		# TODO process the create request
	end
	
	# evaluations/mult
	def mult
		# TODO process the multiple-create request
	end
	
	#
	# ====== PROTECTED SECTION ======
	#
	
	protected
	
	# check if the id parameter is valid
	def validate_id
		unless params[:id] && params[:id].to_i > 0
			flash[:error] = "Identificativo non valido"
			redirect_to evaluations_path, status: :found
		end
	end
	
end
