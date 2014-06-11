module UsersHelper
	include AccessHelper

	# Mask values (join with OR):
	# ACCESS_MYSELF -> Myself
	# ACCESS_STUD   -> Any student in the target's class
	# ACCESS_TEACH  -> Any teacher of the target (me -> teacher, target -> student)
	# ACCESS_COORD  -> Any admin of the target's class (me -> teacher, target -> student)
	# ACCESS_ADMIN  -> Any school administrator
	# ACCESS_ANYONE -> Anyone logged in

	SHOW_TABLE = {
		name: ACCESS_ANYONE,
		surname: ACCESS_ANYONE,
		user_type: ACCESS_ANYONE,
		classes: ACCESS_ADMIN | ACCESS_COORD | ACCESS_TEACH | ACCESS_STUD | ACCESS_MYSELF
	}
	
	# get the accessible information about an user
	def get_user_info me, target
		level = get_user_level me, target
		table = SHOW_TABLE
		
		response = {}
		
		response[:name] = target.name 			if level & table[:name] > 0
		response[:surname] = target.surname		if level & table[:surname] > 0
		response[:user_type] = target.user_type	if level & table[:user_type] > 0
		response[:classes] = target.classes		if level & table[:classes] > 0
		
		return response
	end
	
	# =============
	    protected
	# =============
	
	# get the level of the user about the target
	def get_user_level me, target
		# anyone
		mask = ACCESS_ANYONE
		# school administartor
		mask |= ACCESS_ADMIN if me.admin?
		# class administartor
		mask |= ACCESS_COORD if me.teacher? and target.students? and target.admins.contains me
		# class teacher
		mask |= ACCESS_TEACH if me.teacher? and target.student? and me.same_class? target
		# class student
		mask |= ACCESS_STUD if target.student? and me.same_class? target
		# me
		mask |= ACCESS_MYSELF if me == target
		
		return mask
	end
end
