require "test_helper"

class AcxTest < Minitest::Test
  SAMPLE_BOOK = "A1QZFCX1IB20Z5"

  def setup
    enable_fixtures
  end

  def test_a_title_accepts_a_uid
    book = Acx::Title.new(SAMPLE_BOOK)
  end

  def test_get_amazon_sales_rank
    book = Acx::Title.new(SAMPLE_BOOK)
    assert_equal 290955, book.sales_rank
  end

end
