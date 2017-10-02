require 'open-uri'
require 'nokogiri'

module Acx
  class Title

    def initialize(uid)
      @uid = uid
    end

    def sales_rank
      detail_field("Amazon sales rank")
        .gsub(/[^0-9]/i,'').to_i
    end

    private

    def doc
      @doc ||= Nokogiri::HTML(open(detail_page).read)
    end

    def detail_page
      "https://www.acx.com/titleview/#{@uuid}"
    end

    def detail_field(name)
      doc.xpath(
        "//div[contains(text(), '#{name}')]" \
        "/../div[@class='titleDetailFieldValue']"
      ).text
    end

  end
end
