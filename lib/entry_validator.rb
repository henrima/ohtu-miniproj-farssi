module EntryValidator
  def EntryValidator.field_db 
    {
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
  end

  def EntryValidator.validate entry
    return false if entry['entry_type'].nil?
    return false if entry['cite_key'].nil?

    return false if not field_db.keys.include? entry['entry_type']
    fields = field_db[entry['entry_type']]
    
    # check that required fields are present
    fields.each do |field, required|
      return false if required and entry[field].nil?
    end

    # check that only required/optional fields are present
    entry.each do |key, value|
      if not (key == 'entry_type' or key == 'cite_key') then
        return false if not fields.keys.include?(key) and not value.nil?
      end
    end

    return true
  end
end

