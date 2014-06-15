class EvaluationsController < ApplicationController
	include EvaluationsHelper
	
	before_filter :need_login
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
			index
			render :index
			return
		end
		
		begin
			me = User.find session[:user_id]
			@evaluation = Evaluation.find(params[:id])	
			access = can_show? me, @evaluation
			if not access
				redirect_to eval_index_path
				flash[:error] = "Accesso negato"
				return
			end
		rescue
			flash[:error] = "Valutazione non trovata"
		end
	end
	
	# this shows the list of the evaluations of a class
	def show_class
		
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
	
	# ==================
	#     PROTECTED
	# ==================	
	protected
	
	# check if the id parameter is valid
	def validate_id
		unless params[:id] && params[:id].to_i > 0
			flash[:error] = "Identificativo non valido"
			redirect_to root_path
		end
	end
	
	# check if the user is logged in
	def need_login
		redirect_to login_path unless session[:token]
	end
end
