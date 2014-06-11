module AccessHelper

	# Mask values (join with OR):
	# ACCESS_MYSELF -> Myself
	# ACCESS_STUD   -> Any student in the target's class
	# ACCESS_TEACH  -> Any teacher of the target (me -> teacher, target -> student)
	# ACCESS_COORD  -> Any admin of the target's class (me -> teacher, target -> student)
	# ACCESS_ADMIN  -> Any school administrator
	# ACCESS_ANYONE -> Anyone logged in

	ACCESS_ANYONE = 32
	ACCESS_ADMIN = 16
	ACCESS_COORD = 8
	ACCESS_TEACH = 4
	ACCESS_STUD = 2
	ACCESS_MYSELF = 1
end
