require 'open-uri'
require 'nokogiri'

module Acx
  class Title

    def self.all
      doc = Nokogiri::HTML(open("https://www.acx.com/tsAjax"))
      pages =
        doc.xpath(
          "//a[starts-with(@href, 'javascript:updateSearchResult')]"
        )[-2].text.to_i
      results_from_doc(doc) | (2..pages).map { |p| search_results(p) }.flatten
    end

    def self.search_results(page=1)
      results_from_doc(
        Nokogiri::HTML(open("https://www.acx.com/tsAjax?pageIndex=#{page}"))
      )
    end

    def self.results_from_doc(doc)
      doc
        .xpath("//div[@class='resultInfo']/p/a")
        .map { |a| a['href'].split("/")[2] }
        .map { |uid| self.new(uid) }
    end

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
      "https://www.acx.com/titleview/#{@uid}"
    end

    def detail_field(name)
      doc.xpath(
        "//div[contains(text(), '#{name}')]" \
        "/../div[@class='titleDetailFieldValue']"
      ).text
    end

  end
end
