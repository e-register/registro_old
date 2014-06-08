class EvaluationsController < ApplicationController
	
	before_filter :validate_id, :only => [ :show_class, :show_user, :edit, :update, :destroy ]
	
	# this shows the list of evaluations
	def index
	end
	
	# this shows a single evaluation
	def show
		# if the id was passed, validate it
		if params[:id]
			validate_id
		# if the id wasn't passed, render the index page
		else
			render :index			
		end
		begin
			@evaluation = Evaluation.find(params[:id])
		rescue
			flash[:error] = "Valutazione non trovata"
		end
	end
	
	# this shows the list of the evaluations of a class
	def show_class
		# TODO process the class id
	end
	
	# this shows the list of the evaluations of a user
	def show_user
		# TODO process the user id
	end
	
	# this shows a form to edit an evaluation
	def edit
		# TODO process the evaluation id
	end
	
	# this perform the edit request
	def update
		# TODO process the evaluation id
	end
	
	# this delete an evaluation
	def destroy
		# TODO process the delete request
	end
	
	# this shows a form to create a new evaluation
	def new
		# TODO process the create request
	end
	
	# this perform the create action
	def create
		# TODO process the create request
	end
	
	# this shows a form to add a group of evaluations
	def mult_new
		# TODO process the multiple-create request
	end
	
	# this perform the create of a group of evaluations
	def mult_create
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
			redirect_to root_path, status: :found
		end
	end
	
end
