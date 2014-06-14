module EvaluationsHelper
	include AccessHelper
	
	SHOW_TABLE = {
		# myself means the teacher and the student who own the evaluation
		visible: ACCESS_ADMIN | ACCESS_COORD | ACCESS_MYSELF
	}
	
	def can_show? me, eval
		level = get_user_level me, eval
		table = SHOW_TABLE
		
		return level & table[:visible] > 0
	end
	
	# =============
	    protected
	# =============
	
	# get the level of the user about the evaluation
	def get_user_level me, eval
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
