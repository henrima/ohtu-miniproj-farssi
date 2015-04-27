class BibtexExporter
  def generate(type, key, inputHash)
    stringToReturn = ""
    stringToReturn += "@" + type + "{" + key + ",\n"

    index = inputHash.length
    ending = ",\n"


    #Loop through inputhash
    inputHash.each do |key, value|
      index -= 1
      ending = "\n" if index == 0
      stringToReturn += "  " + key + " = \"" + fixScandicCharacters(value) + "\"" + ending
    end


    stringToReturn += "}
"
    return stringToReturn
  end

  def fixScandicCharacters(string)
    fixedString = ""
    fixes = { "ä" => '{\"a}', "ö" => '{\"o}', "å" => '{\aa}',
              "Ä" => '{\"A}', "Ö" => '{\"O}', "Å" => '{\AA}'}

      string.split("").each do |i|

        if (fixes.has_key?(i))
          fixedString += fixes[i]
        else
          fixedString += i
        end
      end

      return fixedString
    end


  #input =   { "author" => "KÄa3ke", "title" => "Nykänen vankilassa", "journal" => "Seitsemän päivää",
  #            "year" => "2014", "volume" => "asdasd", "number" => "34", "pages" => "13-14", "month" => "feb",
  #            "crossref" => "KB1", "note" => "hienoa"}
  #puts(generate("article", "KB1", input))

end


