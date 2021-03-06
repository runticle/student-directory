@students = [] # an empty array accessible to all methods
require 'csv'
def input_students
  questions = {
    :name => "Please enter a student",
    :cohort => "Enter student cohort",
    :height => "Enter student height",
    :nation => "Enter student nationality."
  }
  puts questions[:name]
  puts "To finish, just hit return once all info has been added"
  # get the first name
  name = STDIN.gets.chomp.capitalize
  # add some more infomation
  puts questions[:cohort]
  input_cohort = STDIN.gets.chomp.capitalize
  input_cohort == "" ? cohort = "November" : cohort = input_cohort
  puts questions[:height]
  height = STDIN.gets.chomp.to_s
  puts questions[:nation]
  nation = STDIN.gets.chomp.capitalize
  # while the name is not empty, repeat this code
  while true do
    add_student_info(name, cohort, height, nation)
    puts "Now we have #{@students.count} student#{+ "s" if @students.count > 1}"
    # get another name from the user
    puts questions[:name]
    name = STDIN.gets.chomp.capitalize
    break if name == ""
    # add some more infomation
    puts questions[:cohort]
    input_cohort = STDIN.gets.chomp.capitalize
    input_cohort == "" ? cohort = "November" : cohort = input_cohort
    puts questions[:height]
    height = STDIN.gets.chomp.to_s
    puts questions[:nation]
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
  user = STDIN.gets.chomp
  case user
  when "1"
    print_header
    print_by_cohort
  when "2"
    print_header
    print_by_name
  else
    puts "Invalid option"
    interactive_menu
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
  puts "3. Save the list"
  puts "4. Load the list"
  puts "9. Exit"
end
def show_students
  print_students_list
  print_footer
end
def save_students
  puts "Save to which file?"
  filename = gets.chomp
  CSV.open(filename, "wb") do |csv|
    @students.each do |student|
      csv << [student[:name], student[:cohort], student[:height], student[:nation]]
    end
  end
  puts "Saved to #{filename}"
end
def load_students(filename)
  if File.exists?(filename)
    CSV.foreach(filename) do |row|
      name, cohort, height, nation = row[0..3]
      add_student_info(name, cohort, height, nation)
    end
    puts "Loaded #{@students.count} from #{filename}"
  else
    puts "Sorry, #{filename} doesn't exist."
    interactive_menu
  end
end
def check_loaded_students(filename)

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
