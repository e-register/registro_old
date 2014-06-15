module PagesHelper
	include AccessHelper
	
	EVALUATION_TABLE = {
		:guest => nil,
		:student => {
			"Accedi al registro" => Rails.application.routes.url_helpers.eval_index_path
		},
		:teacher => {
			"Accedi al registro" => Rails.application.routes.url_helpers.eval_index_path,
			"Aggiungi un voto" => Rails.application.routes.url_helpers.new_evaluations_path
		},
		:admin => {
			"Accedi al registro" => Rails.application.routes.url_helpers.eval_index_path,
			"Aggiungi un voto" => Rails.application.routes.url_helpers.new_evaluations_path
		}
	}
	
	# return an hash with the index of the user
	def get_index user_id
		user_type = get_user_type user_id
		evaluation = EVALUATION_TABLE[user_type]
		
		return { evaluation: evaluation }
	end
	
	# return the symbol of the user type, :guest if not logged in
	def get_user_type user_id
		return :guest if user_id.nil?
		user = User.find user_id
		return :guest if user.nil?
		
		return user.user_type.to_sym
	end
end
