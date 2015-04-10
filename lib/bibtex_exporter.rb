class BibtexExporter
  def self.generate(type, key, inputHash)
    puts "@" + type + "{" + key + ","

    index = inputHash.length
    ending = ","

    inputHash.each do |key, value|
      index -= 1
      ending = "" if index == 0
      puts "  " + key + " = " + fixScandicCharacters(value) + ending
    end

    puts "}"
  end

  def self.fixScandicCharacters(string)
    fixedString = ""
    fixes = { "ä" => '{\"a}'}

      string.split("").each do |i|

        if (fixes.has_key?(i))
          fixedString += fixes[i]
        else
          fixedString += i
        end
      end

      return fixedString
    end




  input =   { "author" => "Kake", "title" => "Nykänen vankilassa", "journal" => "Seitsemän päivää",
              "year" => "2014", "volume" => "asdasd", "number" => "34", "pages" => "13-14", "month" => "feb",
              "crossref" => "KB1", "note" => "hienoa"}

  generate("article", "KB1", input)
end


