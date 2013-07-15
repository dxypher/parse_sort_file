require 'test/unit'
require './file_parser'

class TestFileParser < Test::Unit::TestCase
  def test_split_line
    line = "Smith | Steve | D | M | Red | 3-3-1985"
    expected = ["Smith", "Steve", "D", "M", "Red", "3-3-1985"]

    assert_equal(expected, FileParser.split_line(line))
  end

  def test_split_line2
    line = "Abercrombie, Neil, Male, Tan, 2/13/1943"
    expected = ["Abercrombie", "Neil", "Male", "Tan", "2/13/1943"]

    assert_equal(expected, FileParser.split_line(line))
  end

  def test_split_line3
    line = "Kournikova Anna F F 6-3-1975 Red"
    expected = ["Kournikova", "Anna", "F", "F", "6-3-1975", "Red"]

    assert_equal(expected, FileParser.split_line(line))
  end

  def test_normalize_string_capitalization
    line = ["kournikova", "anna", "f", "F", "6-3-1975", "Red"]
    expected = ["Kournikova", "Anna", "F", "F", "6-3-1975", "Red"]

    assert_equal(expected, FileParser.normalize_string_capitalization(line))
  end

  def test_new_csv_row
    line = ["Abercrombie", "Neil", "Male", "Tan", "2/13/1943"]
    type = "comma" 

    assert_nil(FileParser.new_csv_row(line, type)[2])
  end

  def test_new_csv_row2
    line = ["Abercrombie", "Neil", "Male", "Tan", "2/13/1943"]
    type = "comma"

    assert_kind_of(Date, FileParser.new_csv_row(line, type)[5])
  end

  def test_format_date
    date_string = '6-3-1975'
    assert_kind_of(Date, FileParser.format_date(date_string))
  end

  def test_format_gender
    gender = "F"
    assert_equal("Female", FileParser.format_gender(gender))
  end

  def test_new_data_set
    row = ["Kournikova", "Anna", "F", "F", "Red", "6-3-1975"]
    assert_equal(10, FileParser.new_data_set(row).count)
  end
end