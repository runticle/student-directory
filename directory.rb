def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return thrice once all info has been added"
  # create an empty array
  students = []
  # get the first name
  name = gets.chomp.capitalize
  # add some more infomation
  puts "Enter student cohort"
  input_cohort = gets.chomp
  input_cohort == "" ? cohort = "november" : cohort = input_cohort
  # while the name is not empty, repeat this code
  while !name.empty? do
    # add student hash to the array
    students << {name: name, cohort: cohort.to_sym}
    puts "Now we have #{students.count} student#{+ "s" if students.count > 1}"
    # get another name from the user
    puts "Please enter another student"
    name = gets.chomp.capitalize
    # add some more infomation
    puts "Enter student cohort"
    input_cohort = gets.chomp
    input_cohort == "" ? cohort = "november" : cohort = input_cohort
  end
  # returns the array of students
  students
end
def print_header
  puts "The students of Villans Academy".center(100)
  puts "-------------".center(100)
end
def print(students)
  #  create cohorts hash
  cohorts_list = {}
  students.each { |i|
    name = i[:name]
    cohort = i[:cohort]
    if cohorts_list[cohort] == nil
      cohorts_list[cohort] = [name]
    else
      cohorts_list[cohort].push(name)
    end
  }
    cohorts_list.each { |cohort, names| "#{puts (cohort.to_s + " Cohort").to_s.capitalize.center(100)} #{names.each { |name| puts name.center(100) }}" }
end
def print_footer(names)
  if names.count > 0
    puts "Overall, we have #{names.count} great student#{+ "s" if names.count > 1}\n".center(100)
  else
    puts "There were no students found in the cohort.\n".center(100)
  end
end
# nothing happens until we call the methods
students = input_students
print_header
print(students)
print_footer(students)
