require 'spec_helper'

RSpec.describe BibtexExporter do

  describe "Umlauts" do
    it "get converted into right format" do
      expect('Aa{\"A}{\"O}{\"A}{\"a}{\"o}{\"a}').to eq(BibtexExporter.fixScandicCharacters("AaÄÖÄäöä"))
    end
  end

end