module EntryValidator
  def EntryValidator.validate entry
    return false if !entry['entry_type']
    return false if !entry['cite_key']
    return false if !entry['author']
    true
  end
end

