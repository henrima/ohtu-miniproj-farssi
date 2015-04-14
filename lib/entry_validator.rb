module EntryValidator
  @field_db = {
    'article' => {
      'author' => true,   # true = required, false = optional
      'title' => true,
      'journal' => true,
      'year' => true,
      'volume' => true,
      'number' => false,
      'pages' => false,
      'month' => false,
      'note' => false
    }
  }

  def EntryValidator.validate entry
    return false if not entry.keys.include? 'entry_type'
    return false if not entry.keys.include? 'cite_key'

    return false if not @field_db.keys.include? entry['entry_type']
    fields = @field_db[entry['entry_type']]
    
    # check that required fields are present
    fields.each do |field, required|
      return false if required and entry.keys.include? field
    end

    



    return true
  end
end

