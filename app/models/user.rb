# the base information of a user
class User < ActiveRecord::Base
	# the gender of the user
	enum gender: [ :male, :female ]
	# the type of the user
	enum user_type: [ :admin, :teacher, :student ]

	# a user can have more than one login account
	has_many :credentials
	# a user can have more token
	has_many :tokens

	# validates the parameters
	validate :name, presence: true, lenght: { in: 1..50 }
	validate :surname, presence: true, lenght: { in: 1..50 }
	validate :born_date, presence: true
	validate :born_city, presence: true
	validate :gender, presence: true
	validate :user_type, presence: true

	# generate a new token for the user
	# Return the Token if success, otherwise nil
	def get_new_token
		token = Token.generate_token
		t = Token.new
		t.token = token
		t.user = self
		if t.save
			return t
		else 
			return nil
		end
	end
	
	# extract the classes where the user is in
	def classes
		teach = Teacher.where(teacher: self).to_a.map{ |e| e.class_info }
		stud = Student.where(student: self).to_a.map{ |e| e.class_info }
		return teach.concat(stud).uniq
	end
	
	# check if the user has a mutual class with an other user
	def same_class? user
		return (self.classes & user.classes).length > 0
	end
	
	# extract the administrators of the classes where i'm in
	def admins
		c = self.classes
		a = []
		c.each { |class_info| a << class_info.admin }
		return a.uniq
	end
	
	def full_name
		f = "#{name} #{surname}"
		return f.strip
	end
end
