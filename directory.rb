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
  puts "Enter students' height in metres"
  height = gets.chomp.to_s
  puts "Enter students' nationality"
  nation = gets.chomp.capitalize
  # while the name is not empty, repeat this code
  while !name.empty? do
    # add student hash to the array
    students << {name: name, cohort: cohort.to_sym, nation: nation, height: height}
    puts "Now we have #{students.count} student#{+ "s" if students.count > 1}"
    # get another name from the user
    puts "Please enter another student"
    name = gets.delete("\n").capitalize
    # add some more infomation
    puts "Enter student cohort"
    input_cohort = gets.delete("\n")
    input_cohort == "" ? cohort = "november" : cohort = input_cohort
    puts "Enter students' height in metres"
    height = gets.delete("\n").to_s
    puts "Enter students' nationality"
    nation = gets.delete("\n").capitalize
  end
  # returns the array of students
  students
end
def print_header
  puts "The students of Villans Academy".center(100)
  puts "-------------".center(100)
end
def print(students)
  if students.count > 0
    i = 0
    until students.count == i do
      puts "#{i + 1}. #{students[i][:name]} (Height: #{students[i][:height]}m, Nationality: #{students[i][:nation]}, #{students[i][:cohort]} cohort)".center(100) if students[i][:name].length < 12
      i += 1
    end
  end
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
