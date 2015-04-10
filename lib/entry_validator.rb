module EntryValidator
  def EntryValidator.validate entry
    return false if !entry['entry_type']
    return false if !entry['cite_key']
    return false if !entry['author']
    return false if !entry['title']
    return false if !entry['journal']
    return false if !entry['year']
    return false if !entry['volume']
    true
  end
end

