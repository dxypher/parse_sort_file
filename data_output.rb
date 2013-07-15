module DataOutput
  CSV_FILE_PATH = File.join(File.dirname(__FILE__), "output.csv")
  ################# Output of New Sorted Data Set ###################
  def print_new_data_set
    lines = CSV.readlines(CSV_FILE_PATH, headers: true, header_converters: :symbol )
    lines.each do |line|
      puts "#{line[:last_name]} #{line[:first_name]} #{line[:gender]} #{format_date_str(line[:date_of_birth])} #{line[:favorite_color]}"
    end
  end

  def format_date_str(date)
    a = Date.strptime(date, "%Y-%m-%d").strftime("%-m/%-d/%Y")
  end
end