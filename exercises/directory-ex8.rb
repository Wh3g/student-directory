def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  # create an empty array
  students = []
  name = gets.chomp
  # while the name is not empty, repeat this code
  while !name.empty? do
    puts "Enter the cohort"
    cohort = gets.chomp.downcase.to_sym
    loop do
      if cohort == :january || cohort == :february || cohort == :march || cohort == :april || cohort == :may || cohort == :june || cohort == :july || cohort == :august || cohort == :september || cohort == :october || cohort == :november || cohort == :december
        break
      else
        puts "Please reenter the cohort month"
        cohort = gets.chomp.downcase.to_sym
      end
    end
    # add the student hash to the array
    students << {name: name, cohort: cohort}
    puts "Now we have #{students.count} students"
    # get another name from the user
    name = gets.chomp
  end
  # return the array of students
  students
end

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print(students)
  list = students.map {|student| student[:cohort]}
  list.uniq!
  list.each do |month|
    puts month
    students.each do |student|
      if student[:cohort] == month
        puts student[:name]
      end
    end
  end
end

def print_footer(names)
  puts "Overall we have #{names.count} great students"
end

students = input_students
print_header
print(students)
print_footer(students)