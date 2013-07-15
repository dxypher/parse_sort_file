require 'date'
require './data_sort'
require './data_output'
require 'csv'

################# New Data Set Creation Methods #################################
module FileParser
  extend DataSort
  extend DataOutput

  def self.parse_file(*file_names, output_type)
    @@new_data_set = []
    type = nil
    file_names.each do |file_name|
      lines = File.readlines("files/#{file_name}")
      type = File.basename(file_name, '.*')
      self.clean_lines(lines, type)
    end
    self.create_output_file(@@new_data_set, output_type)
  end

  def self.clean_lines(lines, type)
    lines.each do |line|
      line = self.split_line(line)
      line = self.normalize_string_capitalization(line)
      new_row = self.new_csv_row(line, type)
      line = self.new_data_set(new_row)
    end
  end

  def self.split_line(line)
    line.split(/[,|\s]+/)
  end

  def self.normalize_string_capitalization(line)
    line.each do |string|
      string.capitalize!
    end
  end

  def self.new_csv_row(attrs, type)
    if type == 'pipe'
      new_row = [attrs[0], attrs[1], attrs[2],self.format_gender(attrs[3]), attrs[4], self.format_date(attrs[5])]
    elsif type == 'comma'
      new_row = [attrs[0], attrs[1], nil, self.format_gender(attrs[2]), attrs[3], self.format_date(attrs[4])]
    elsif type == 'space'
      new_row = [attrs[0], attrs[1], attrs[2], self.format_gender(attrs[3]), attrs[5], self.format_date(attrs[4])]
    end
  end

  def self.format_date(date)
    date.gsub!('/', '-')
    Date.strptime(date, "%m-%d-%Y")
  end

  def self.format_gender(gender)
    gender == "F" || gender == "Female" ? "Female" : "Male"
  end

  def self.new_data_set(new_row)
    @@new_data_set << new_row
  end

end

puts '##################### OUTPUT 1 #################################'
FileParser.parse_file('pipe.txt', 'comma.txt', 'space.txt', 'output_1')
puts '##################### OUTPUT 2 #################################'
FileParser.parse_file('pipe.txt', 'comma.txt', 'space.txt', 'output_2')
puts '##################### OUTPUT 3 #################################'
FileParser.parse_file('pipe.txt', 'comma.txt', 'space.txt', 'output_3')