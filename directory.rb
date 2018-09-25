def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  # create an empty array
  students = []
  # get the first name
  name = gets.chomp.capitalize
  # while the name is not empty, repeat this code
  while !name.empty? do
    # add student hash to the array
    students << {name: name, cohort: :november}
    puts "Now we have #{students.count} students"
    # get another name from the user
    name = gets.chomp.capitalize
  end
  # returns the array of students
  students
end
def print_header
  puts "The students of Villans Academy"
  puts "-------------"
end
def print(students)
  i = 0
  until students.count == i do
    puts "#{i + 1}. #{students[i][:name]} (#{students[i][:cohort]} cohort)" if students[i][:name].length < 12
    i += 1
  end

end
def print_footer(names)
  puts "Overall, we have #{names.count} great students"
end
# nothing happens until we call the methods
students = input_students
print_header
print(students)
print_footer(students)
