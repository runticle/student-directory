@students = [] # an empty array accessible to all methods
def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return thrice once all info has been added"
  # get the first name
  name = gets.chomp.capitalize
  # add some more infomation
  puts "Enter student cohort"
  input_cohort = gets.chomp.capitalize
  input_cohort == "" ? cohort = "November" : cohort = input_cohort
  puts "Enter students' height in metres"
  height = gets.chomp.to_s
  puts "Enter students' nationality"
  nation = gets.chomp.capitalize
  # while the name is not empty, repeat this code
  while !name.empty? do
    # add student hash to the array
    @students << {name: name, cohort: cohort.to_sym, nation: nation, height: height}
    puts "Now we have #{@students.count} student#{+ "s" if @students.count > 1}"
    # get another name from the user
    puts "Please enter another student"
    name = gets.chomp.capitalize
    # add some more infomation
    puts "Enter student cohort"
    input_cohort = gets.chomp.capitalize
    input_cohort == "" ? cohort = "November" : cohort = input_cohort
    puts "Enter students' height in metres"
    height = gets.chomp.to_s
    puts "Enter students' nationality"
    nation = gets.chomp.capitalize
  end
end
def print_header
  puts "The students of Villans Academy".center(100)
  puts "-------------".center(100)
end
def print_students_list
  puts "Enter 1 to print by cohort or 2 to print by name"
  user = gets.chomp.to_i
  if user == 1
    print_header
    print_by_cohort
  elsif user == 2
    print_header
    print_by_name
  else
    puts "Invalid option"
    exit
  end
end
def print_by_cohort
  cohorts_list = {}
  @students.each { |i|
    name = i[:name]
    cohort = i[:cohort]
    if cohorts_list[cohort] == nil
      cohorts_list[cohort] = [name]
    else
      cohorts_list[cohort].push(name)
    end
  }
    cohorts_list.each { |cohort, names| "#{puts (cohort.to_s + " Cohort").center(100)} #{names.each { |name| puts name.center(100) }}" }
end
def print_by_name
  if @students.count > 0
    i = 0
    until @students.count == i do
      puts "#{i + 1}. #{@students[i][:name]} (Height: #{@students[i][:height]}m, Nationality: #{@students[i][:nation]}, #{@students[i][:cohort]} cohort)".center(100) if @students[i][:name].length < 12
      i += 1
    end
  end
end
def print_footer
  if @students.count > 0
    puts "Overall, we have #{@students.count} great student#{+ "s" if @students.count > 1}\n".center(100)
  else
    puts "There were no students found in the cohort.\n".center(100)
  end
end
def interactive_menu
  loop do
    print_menu
    process(gets.chomp)
  end
end
def process(selection)
  case selection
    when "1"
      students = input_students
    when "2"
      show_students
    when "3"
      save_students
    when "9"
      exit
    else
      puts "I don't know what you meant, try again"
  end
end
def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "9. Exit"
end
def show_students
  print_students_list
  print_footer
end
def save_students
  file = File.open("students.csv", "w")
  @students.each { |student|
      student_data = [student[:name], student[:cohort], student[:height], student[:nation]]
      csv_line = student_data.join(",")
      file.puts csv_line
  }
  file.close
end
# nothing happens until we call the methods
interactive_menu
