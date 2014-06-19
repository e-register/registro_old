module UsersHelper
	include AccessHelper

	SHOW_TABLE = {
		name: ACCESS_ADMIN | ACCESS_COORD | ACCESS_TEACH | ACCESS_STUD | ACCESS_MYSELF,
		surname: ACCESS_ADMIN | ACCESS_COORD | ACCESS_TEACH | ACCESS_STUD | ACCESS_MYSELF,
		born_date: ACCESS_ADMIN | ACCESS_COORD | ACCESS_TEACH | ACCESS_MYSELF,
		born_city: ACCESS_ADMIN | ACCESS_COORD | ACCESS_TEACH | ACCESS_MYSELF,
		gender: ACCESS_ADMIN | ACCESS_COORD | ACCESS_TEACH | ACCESS_STUD | ACCESS_MYSELF,
		user_type: ACCESS_ADMIN | ACCESS_COORD | ACCESS_TEACH | ACCESS_STUD | ACCESS_MYSELF,
		classes: ACCESS_ADMIN | ACCESS_COORD | ACCESS_TEACH | ACCESS_STUD | ACCESS_MYSELF
	}
	EDIT_TABLE = {
		name: ACCESS_ADMIN | ACCESS_COORD,
		surname: ACCESS_ADMIN | ACCESS_COORD,
		born_date: ACCESS_ADMIN | ACCESS_COORD,
		born_city: ACCESS_ADMIN | ACCESS_COORD,
		gender: ACCESS_ADMIN | ACCESS_COORD,
		user_type: ACCESS_ADMIN
	}
	NEW_TABLE = {
		create: ACCESS_ADMIN
	}

	# get the accessible information about an user
	def get_user_info me, target
		level = get_user_level me, target
		table = SHOW_TABLE

		response = {}

		response[:name] = target.name 			if level & table[:name] > 0
		response[:surname] = target.surname		if level & table[:surname] > 0
		response[:born_date] = target.born_date	if level & table[:born_date] > 0
		response[:born_city] = target.born_city	if level & table[:born_city] > 0
		response[:gender] = target.gender		if level & table[:gender] > 0
		response[:user_type] = target.user_type	if level & table[:user_type] > 0
		response[:classes] = target.classes		if level & table[:classes] > 0

		return response
	end

	# get the editable information about target by me
	def get_edit_info me, target
		level = get_user_level me, target
		table = EDIT_TABLE

		response = []
		table.each { |p, l| response << p if level & l > 0 }

		return response
	end

	# get the access information to create a new user
	def get_new_info me
		level = get_user_level me
		table = NEW_TABLE

		response = {
			create: level & table[:create] > 0
		}

		return response
	end

	# =============
	    protected
	# =============

	# get the level of the user about the target
	def get_user_level me, target = me
		# anyone
		mask = ACCESS_ANYONE
		# school administartor
		mask |= ACCESS_ADMIN if me.admin?
		# class administartor
		mask |= ACCESS_COORD if me.teacher? and target.student? and target.admins.include? me
		# class teacher
		mask |= ACCESS_TEACH if me.teacher? and target.student? and me.same_class? target
		# class student
		mask |= ACCESS_STUD if target.student? and me.same_class? target
		# me
		mask |= ACCESS_MYSELF if me == target

		return mask
	end
end
