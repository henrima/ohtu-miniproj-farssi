require 'rails_helper'

RSpec.describe BibtexExporter do

  describe "Umlauts" do
    it "get converted into right format" do
      expect('Aa{\"A}{\"O}{\"A}{\"a}{\"o}{\"a}').to eq(BibtexExporter.fixScandicCharacters("AaÄÖÄäöä"))
    end
  end

  describe "bibtex" do
    it "gets generated from hash" do
      input =   { "author" => "KÄa3ke", "title" => "Nykänen vankilassa", "journal" => "Seitsemän päivää",
                  "year" => "2014", "volume" => "asdasd", "number" => "34", "pages" => "13-14", "month" => "feb",
                  "crossref" => "KB1", "note" => "hienoa"}
      expect(BibtexExporter.generate("article", "KB1", input)).to eq("@article{KB1,\n  author = K{\\\"A}a3ke,\n  title = Nyk{\\\"a}nen vankilassa,\n  journal = Seitsem{\\\"a}n p{\\\"a}iv{\\\"a}{\\\"a},\n  year = 2014,\n  volume = asdasd,\n  number = 34,\n  pages = 13-14,\n  month = feb,\n  crossref = KB1,\n  note = hienoa\n}")
    end
  end
end