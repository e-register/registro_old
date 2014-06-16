namespace :db do
  desc "Populate the database with an amount of random data"
  task populate: :environment do
  	# load the generation parameters  
  	num_classes = ENV['num_classes'] ? ENV['num_classes'] : 20
  	min_stud_per_class = ENV['min_stud_per_class'] ? ENV['min_stud_per_class'] : 15
  	max_stud_per_class = ENV['max_stud_per_class'] ? ENV['max_stud_per_class'] : 28
  	num_subjects = ENV['num_subjects'] ? ENV['num_subjects'] : 20
  	num_teachers = ENV['num_teachers'] ? ENV['num_teachers'] : 30
  	max_subj_per_teach = ENV['max_subj_per_teach'] ? ENV['max_subj_per_teach'] : 2
  	max_class_per_subj = ENV['max_class_per_subj'] ? ENV['max_class_per_subj'] : 2
  	num_eval_per_teach = ENV['num_eval_per_teach'] ? ENV['num_eval_per_teach'] : 10
  	start_date = ENV['start_date'] ? ENV['start_date'] : "2013-09-01"
  	end_date = ENV['end_date'] ? ENV['end_date'] : "2014-06-11"
  	num_score = ENV['num_score'] ? ENV['num_score'] : 37
  end
end
