require 'test/unit'
require './data_sort'
require './file_parser'
require 'csv'

class TestDataSort < Test::Unit::TestCase
  def setup
    @csv = CSV.open("./tests/test.csv", headers: true, header_converters: :symbol )
    @array_of_result_strings = lambda {|csv_rows, result| 
                                       csv_rows.each do |row|
                                          result << row.to_s
                                       end}

    @expected_output_1 = ["Kournikova,Anna,F,Female,Red,1975-06-03\n",
                          "Seles,Monica,H,Female,Black,1973-12-02\n",
                          "Abercrombie,Neil,,Male,Tan,1943-02-13\n",
                          "Hingis,Martina,M,Male,Green,1979-04-02\n"]

    @expected_output_2 = ["Abercrombie,Neil,,Male,Tan,1943-02-13\n",
                          "Seles,Monica,H,Female,Black,1973-12-02\n",
                          "Kournikova,Anna,F,Female,Red,1975-06-03\n",
                          "Hingis,Martina,M,Male,Green,1979-04-02\n"]

    @expected_output_3 = ["Seles,Monica,H,Female,Black,1973-12-02\n",
                          "Kournikova,Anna,F,Female,Red,1975-06-03\n",
                          "Hingis,Martina,M,Male,Green,1979-04-02\n",
                          "Abercrombie,Neil,,Male,Tan,1943-02-13\n"]
  end
  def test_sort_by_gender_last_name
    result = []
    csv_rows = FileParser.sort_by_gender_last_name(@csv)
    @array_of_result_strings.call(csv_rows, result)

    assert_equal(@expected_output_1 , result)
  end

  def test_sort_by_birth_date
    result = []
    csv_rows = FileParser.sort_by_birth_date(@csv)
    @array_of_result_strings.call(csv_rows, result)

    assert_equal(@expected_output_2 , result)
  end

  def test_sort_by_last_name_desc
    result = []
    csv_rows = FileParser.sort_by_last_name_desc(@csv)
    @array_of_result_strings.call(csv_rows, result)

    assert_equal(@expected_output_3 , result)
  end
end