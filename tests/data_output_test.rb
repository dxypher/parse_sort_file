require 'test/unit'
require './data_output'
require './file_parser'
require 'csv'

class TestDataOutput < Test::Unit::TestCase

  def test_print_new_data_set
    assert_kind_of(CSV::Table, FileParser.print_new_data_set)
  end

  def test_print_new_data_set2
    assert_equal(9, FileParser.print_new_data_set.size)
  end

  def test_format_date_str
    assert_equal("12/2/1973", FileParser.format_date_str("1973-12-02") )
  end
end

