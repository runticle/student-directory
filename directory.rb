@students = [] # an empty array accessible to all methods
def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return thrice once all info has been added"
  # get the first name
  name = STDIN.gets.chomp.capitalize
  # add some more infomation
  puts "Enter student cohort"
  input_cohort = STDIN.gets.chomp.capitalize
  input_cohort == "" ? cohort = "November" : cohort = input_cohort
  puts "Enter students' height in metres"
  height = STDIN.gets.chomp.to_s
  puts "Enter students' nationality"
  nation = STDIN.gets.chomp.capitalize
  # while the name is not empty, repeat this code
  while !name.empty? do
    add_student_info(name, cohort, height, nation)
    puts "Now we have #{@students.count} student#{+ "s" if @students.count > 1}"
    # get another name from the user
    puts "Please enter another student"
    name = STDIN.gets.chomp.capitalize
    # add some more infomation
    puts "Enter student cohort"
    input_cohort = STDIN.gets.chomp.capitalize
    input_cohort == "" ? cohort = "November" : cohort = input_cohort
    puts "Enter students' height in metres"
    height = STDIN.gets.chomp.to_s
    puts "Enter students' nationality"
    nation = STDIN.gets.chomp.capitalize
  end
end
def print_header
  puts "The students of Villains Academy".center(100)
  puts "-------------".center(100)
end
def print_students_list
  puts "1. Print by cohort"
  puts "2. Print by name"
  puts "3. Return to menu"
  user = STDIN.gets.chomp
  case user
  when "1"
    print_header
    print_by_cohort
  when "2"
    print_header
    print_by_name
  when "3"
    interactive_menu
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
    process(STDIN.gets.chomp)
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
    when "4"
      puts "Load which file?"
      filename = gets.chomp
      load_students(filename)
    when "9"
      puts "You quit"
      exit
    else
      puts "I don't know what you meant, try again"
  end
end
def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "4. Load the list from students.csv"
  puts "9. Exit"
end
def show_students
  print_students_list
  print_footer
end
def save_students
  puts "Save to which file?"
  filename = gets.chomp
  file = File.open(filename, "w") {|file|
    @students.each { |student|
        student_data = [student[:name], student[:cohort], student[:height], student[:nation]]
        csv_line = student_data.join(",")
        file.puts csv_line
    }
  }
  puts "Saved to #{filename}"
end
def load_students(filename)
  if File.exists?(filename)
    file = File.open(filename, "r") { |file|
      file.readlines.each { |line|
        name, cohort, height, nation = line.chomp.split(",")
        add_student_info(name, cohort, height, nation)
      }
    }
  puts "Loaded #{@students.count} from #{filename}"
  else
    puts "Sorry, #{filename} doesn't exist."
    interactive_menu
  end
end
def try_load_students
  filename = ARGV.first # first argument from the command line
  filename = "students.csv" if filename.nil? # get out of the method if it isn't given
  load_students(filename)
end
def add_student_info(name, cohort, height, nation)
  @students << {name: name, cohort: cohort.to_sym, height: height, nation: nation}
end
# nothing happens until we call the methods
try_load_students
interactive_menu
