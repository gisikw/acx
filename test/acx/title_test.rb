require "test_helper"

class AcxTest < Minitest::Test
  SAMPLE_BOOK = "A1QZFCX1IB20Z5"

  def setup
    enable_fixtures
  end

  def test_query_all_titles
    books = Acx::Title.all
    assert books.length
    assert_equal 2020597, books[0].sales_rank
  end

  def test_a_title_accepts_a_uid
    book = Acx::Title.new(SAMPLE_BOOK)
  end

  def test_title_details
    book = Acx::Title.new(SAMPLE_BOOK)
    assert_equal "Religion & Spirituality", book.genre
    assert_equal "English", book.language
    assert_equal "Male", book.gender
    assert_equal "Adult", book.character_age
    assert_equal "American-General American", book.accent
    assert_equal "Articulate", book.vocal_style
    assert_equal "CCS Publishing", book.published_by
    assert_equal "290955", book.amazon_sales_rank
    assert_equal "4.6 (9 ratings)", book.amazon_rating
  end

end
