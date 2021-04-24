require 'csv'
@students = []

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to a .csv file"
  puts "4. Load the list from a .csv file"
  puts "9. Exit"
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
    input_students
  when "2"
    show_students
  when "3"
    save_students
    puts "Success!"
  when "4"
    load_students(filename_input)
    puts "Success!"
  when "9"
    exit
  else
    puts "I don't know what you meant, try again"
  end
end

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  name = STDIN.gets.chomp
  # while the name is not empty, repeat this code
  while !name.empty? do
    # add the student hash to the array
    add_student(name, :november)
    puts "Now we have #{@students.count} students"
    # get another name from the user
    name = STDIN.gets.chomp
  end
end

def add_student(name, cohort)
  @students << {name: name, cohort: cohort}
end

def show_students
  print_header
  print_students_list
  print_footer
end

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print_students_list
  @students.each do |student|
    puts "#{student[:name]} (#{student[:cohort]} cohort)"
  end
end

def print_footer
  puts "Overall we have #{@students.count} great students"
end

def save_students
  filename = filename_input
  csv_file = CSV.generate do |csv|
    @students.each do |student|
      csv << [student[:name], student[:cohort]]
    end
  end
  File.open(filename, "w") do |file|
    file.puts csv_file
  end
end

def load_students(filename = "students.csv")
  CSV.foreach(filename) do |r|
    add_student(r[0], r[1].to_sym)
  end
end

def try_load_students
  filename = ARGV.first
  if filename.nil?
    load_students
     puts "Loaded #{@students.count} from students.csv"
  elsif File.exists?(filename)
    load_students(filename)
     puts "Loaded #{@students.count} from #{filename}"
  else
    puts "Sorry #{filename} doesn't exist."
    exit
  end
end

def filename_input
  puts "Enter file name ending in \".csv\":"
  filename = gets.chomp
  while filename[-4..-1] != ".csv"
    puts "I'm sorry that doesn't look like a .csv file, please try again"
    filename = gets.chomp
  end
  return filename
end

try_load_students
interactive_menu