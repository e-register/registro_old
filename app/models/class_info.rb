# this contains the informations about a class
class ClassInfo < ActiveRecord::Base
	# a class has an administrator (which is an user)
	belongs_to :admin, :class_name => User
end
