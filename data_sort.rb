module DataSort
  CSV_FILE_PATH = File.join(File.dirname(__FILE__), "output.csv")

  def create_output_file(data_array, output_type)
    write_to_csv(data_array) # create initial un-sorted csv
    sorted_array = sort_csv(output_type)
    write_to_csv(sorted_array) # overwrite initial csv with sorted data
    self.print_new_data_set
  end

  def write_to_csv(data_array)
    CSV.open(CSV_FILE_PATH, "wb") do |csv|
      csv << %w[last_name first_name middle_initial gender favorite_color date_of_birth]
      data_array.each do |new_line|
        csv << new_line
      end
    end
  end

  def sort_csv(output_type)
    CSV.open(CSV_FILE_PATH, headers: true, header_converters: :symbol ) do |csv|
      if output_type == "output_1"
        self.sort_by_gender_last_name(csv)
      elsif output_type == "output_2"
        self.sort_by_birth_date(csv)
      elsif output_type == "output_3"
        self.sort_by_last_name_desc(csv)
      end
    end
  end

  def sort_by_gender_last_name(csv)
    csv.sort_by{ |a| [a[:gender], a[:last_name]]}
  end

  def sort_by_birth_date(csv)
    csv.sort_by{|a| a[:date_of_birth]}
  end

  def sort_by_last_name_desc(csv)
    csv.sort{ |a,b| b[:last_name] <=> a[:last_name]}
  end
end