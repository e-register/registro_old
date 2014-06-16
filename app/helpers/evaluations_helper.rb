module EvaluationsHelper
	include AccessHelper
	
	SHOW_TABLE = {
		# myself means the teacher and the student who own the evaluation
		visible: ACCESS_ADMIN | ACCESS_COORD | ACCESS_MYSELF
	}
	
	# check if the user can view the evaluation, according to the SHOW_TABLE
	def can_show? me, eval
		table = SHOW_TABLE
		level = get_user_level me, eval
		
		return level & table[:visible] > 0
	end
	
	# check witch of a series of evaluations can be viewed
	def can_show_multiple me, evals
		table = SHOW_TABLE
		visible = []
		
		evals.each { |e| visible << e if can_show? me, e }
		
		return visible
	end
	
	# =============
	    protected
	# =============
	
	# get the level of the user about the evaluation
	def get_user_level me, eval
		# this will load:
		# if me.teacher?
		# 	- the student of the evaluation
		# 		- the classes of the user (teacher or student)
		# 		- the admin of each class
		# if me.student?
		#	- the student of the evaluation
		#		- the classes of the user
		#		- the classes of the student	
	
		level = ACCESS_ANYONE
		# school administrator
		level |= ACCESS_ADMIN if me.admin?
		# class administrator
		level |= ACCESS_COORD if me.teacher? and eval.student.admins.contains me
		# class teacher
		level |= ACCESS_TEACH if me.teacher? and eval.student.same_class? me
		# class student
		level |= ACCESS_STUD if me.student? and eval.student.same_class? me
		# the student or the teacher
		level |= ACCESS_MYSELF if me == eval.student or me == eval.teacher
		
		return level
	end
end
