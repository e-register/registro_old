namespace :db do
	require 'password_hash'

	desc 'Truncate all tables'
	task :truncate => :environment do	 
		puts '** Truncating'
		ActiveRecord::Base.connection.tables.each do |table|	 
			unless %w(schema_migrations rails_admin_histories).include? table
				t = table.classify
				ActiveRecord::Base.connection.execute("TRUNCATE TABLE #{table};")
			end
		end
	end

  desc "Populate the database with an amount of random data"
  task populate: :environment do
  	# load the generation parameters  
  	num_classes = ENV['num_classes'] || 20
  	num_students = ENV['num_students'] || 500
  	num_subjects = ENV['num_subjects'] || 20
  	num_teachers = ENV['num_teachers'] || 30
  	max_tuple_per_class = ENV['max_tuple_per_class'] || 15
  	max_eval_per_student = ENV['num_eval_per_student'] || 10
  	start_date = ENV['start_date'] || "2013-09-01"
  	end_date = ENV['end_date'] || "2014-06-11"

	startTruncate = Time.now  
  	Rake::Task["db:truncate"].invoke

	startGeneration = Time.now
  	puts "** Population started!"
  	
  	classes = create_classes num_classes  	
  	subjects = create_subjects num_subjects
  	users_teacher = create_users_teacher num_teachers
  	teachers = create_teachers classes, subjects, users_teacher, max_tuple_per_class
  	users_student = create_users_student num_students, num_teachers
  	students = create_students classes, users_student
  	credentials = create_credentials users_teacher, users_student
  	scores = create_scores
  	evaluations = create_evaluations teachers, students, scores, max_eval_per_student, start_date, end_date
  	
  	startPopulation = Time.now
  	puts "** All data is generated! Let's save!"
  	
  	puts "   == #{classes.length} classes"
  	big_query(ClassInfo, classes)
  	puts "   ==> #{classes.length} classes saved"
  	
  	puts "   == #{subjects.length} subjects"
  	big_query(Subject, subjects)
  	puts "   ==> #{subjects.length} subjects saved"
  	
  	puts "   == #{users_teacher.length} teachers user"
  	big_query(User, users_teacher)
  	puts "   ==> #{users_teacher.length} teachers user saved"
  	
  	puts "   == #{teachers.length} teachers"
  	big_query(Teacher, teachers)
  	puts "   ==> #{teachers.length} teachers saved"
  	
  	puts "   == #{users_student.length} students user"
  	big_query(User, users_student)
  	puts "   ==> #{users_student.length} students user saved"
  	
  	puts "   == #{students.length} students"
  	big_query(Student, students)
  	puts "   ==> #{students.length} students saved"
  	
  	puts "   == #{credentials.length} credentials"  	
  	big_query(Credential, credentials)
  	puts "   ==> #{credentials.length} credentials saved"
  	
  	puts "   == #{scores.length} scores"  	
  	big_query(Score, scores)
  	puts "   ==> #{scores.length} scores saved"
  	
  	puts "   == #{evaluations.length} evaluations"
  	big_query(Evaluation, evaluations)
  	puts "   ==> #{evaluations.length} evaluations saved"
  	
  	endTime = Time.now
  	
  	puts "** TOTAL TIME    #{approx(endTime-startTruncate,3)} sec"
  	puts "   TRUNC TIME    #{((startGeneration-startTruncate)*1000).to_i} ms"
  	puts "   GEN TIME      #{((startPopulation-startGeneration)*1000).to_i} ms"
  	puts "   POPULATE TIME #{approx(endTime-startPopulation, 3)} sec"
  end
  
  def clamp x, min, max
  	[min, [x, max].min].max
  end
  def approx num, dec
  	((num*(10**dec)).to_i).to_f/(10**dec)
  end
  def big_query model, data
  	model.transaction do
  		data.each { |d| model.create(d) }
  	end
  end
  def rand_date from, to
  	from = Time.parse(from)
  	to = Time.parse(to)
  	time = Time.at(from + rand * (to.to_f - from.to_f))
  	Date.civil(time.year, time.month, time.day)
  end
  
  def create_classes num_classes
  	num_classes = num_classes.to_i
  	classes = []
  	curr_class = 1
  	curr_year = 1
  	alpha = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
	for i in 1..num_classes do
		c = {}
		c[:id] = i
		if curr_class <= alpha.length
			c[:name] = "#{curr_year}^ #{alpha[curr_class-1]}"
		else
			c[:name] = "#{curr_year}^ #{alpha[curr_class/alpha.length-1]}#{alpha[curr_class%alpha.length-1]}"
		end
		c[:specialization] = "informatica"
		c[:year] = curr_year
		c[:admin] = nil
		classes << c
		if curr_class >= num_classes / 5
			curr_year += 1
			curr_class = 0
		end
		curr_class += 1
	end
	return classes
  end
  
  def create_subjects num_subjects
  	num_subjects = num_subjects.to_i
	subjects = []
  	
  	for i in 1..num_subjects do
  		s = {}
  		s[:id] = i
  		s[:name] = "Materia #{i}"
  		s[:description] = "Materia #{i}"
  		subjects << s
  	end
  	
  	return subjects
  end
  
  def create_users_teacher num_teachers
  	num_teachers = num_teachers.to_i
  	users = []
  	
  	for i in 1..num_teachers do
  		u = {}
  		u[:id] = i
  		u[:name] = "Docente"
  		u[:surname] = "#{i}"
  		u[:gender] = rand(2)
  		u[:user_type] = :teacher
  		
  		users << u
  	end
  	
  	return users
  end
  
  def create_teachers classes, subjects, teachers, max_tuple_per_class
 	max_tuple_per_class = max_tuple_per_class.to_i
  	tuples = []
  	num_teachers = teachers.length
  	num_subjects = subjects.length
  	classes.each do |c|
  		# the num of tuple is in [max/2,max[
  		num_tuple = rand((max_tuple_per_class/2)...max_tuple_per_class)
  		num_tuple.times do
	  		t = {}
	  		t[:id] = tuples.length+1
	  		t[:class_info_id] = c[:id]
	  		teacher = teachers[rand(num_teachers)]
	  		t[:teacher_id] = teacher[:id]
	  		t[:subject_id] = subjects[rand(num_subjects)][:id]
	  		
	  		# set the class admin
	  		c[:admin_id] = teacher[:id] if c[:admin].nil?
	  		
	  		tuples << t
  		end
  	end
  	return tuples.uniq do |t| 
  		{
  			class_info_id: t[:class_info_id], 
  			teacher_id: t[:teacher_id],
  			subject_id: t[:subject_id]
  		}
  		end
  end
  
  def create_users_student num_students, num_teachers
  	num_students = num_students.to_i
  	students = []
  	
  	for i in 1..num_students do
  		u = {}
  		u[:id] = num_teachers + i
  		u[:name] = "Studente"
  		u[:surname] = "#{i}"
  		u[:gender] = rand(2)
  		u[:user_type] = :student
  		
  		students << u
  	end
  	
  	return students
  end
  
  def create_students classes, students
  	num_classes = classes.length
  	studs = []
  	students.each do |e|
  		s = {}
  		s[:id] = studs.length + 1
  		s[:class_info_id] = classes[rand(num_classes)][:id]
  		s[:student_id] = e[:id]
  		
  		studs << s
  	end
  	return studs
  end
  
  def create_credentials teachers, students
  	credentials = []
  	teachers.each do |t|
  		c = {
  			username: "teach#{t[:id]}",
  			password: PasswordHash.createHash("password"),
  			user_id: t[:id]
  		}
  		credentials << c
  	end
  	num_teachers = teachers.length
  	students.each do |s|
  		c = {
  			username: "stud#{s[:id]-num_teachers}",
  			password: PasswordHash.createHash("password"),
  			user_id: s[:id]
  		}
  		credentials << c
  	end
  	return credentials
  end
  
  def create_scores
  	scores = []
  	for i in 2..9 do
  		scores << { id: (i-2)*4+1, text: i.to_s, value: i.to_f }
  		scores << { id: (i-2)*4+2, text: "#{i}+", value: i+0.25 }
  		scores << { id: (i-2)*4+3, text: "#{i}.5", value: i+0.5 }
  		scores << { id: (i-2)*4+4, text: "#{i+1}-", value: i+0.75 }
  	end
  	scores << { id: 37, text: "10", value: 10.0 }
  	return scores
  end
  
  def create_evaluations teachers, students, scores, max_eval_per_student, start_date, end_date
  	evaluations = []
  	num_scores = scores.length
  	teachers.each do |t|
  		students.each do |s|
  			if t[:class_info_id] == s[:class_info_id]
  				avar = rand(0..num_scores)
  				num_eval = rand((max_eval_per_student/2)...max_eval_per_student)
  				num_eval.times do 
  					e = {}
  					e[:id] = evaluations.length + 1
  					e[:teacher_id] = t[:teacher_id]
  					e[:student_id] = s[:student_id]
  					e[:subject_id] = t[:subject_id]
  					e[:date] = rand_date(start_date, end_date)
  					score_idx = clamp avar+rand(-6..6), 0, num_scores-1
  					e[:score_id] = scores[score_idx][:id]
  					e[:evaluation_type] = rand(3)
  					e[:class_test] = nil
  					evaluations << e
  				end
  			end
  		end
  	end
  	return evaluations
  end
end
