module EntryValidator
  def EntryValidator.validate entry
    return false if 
      !entry['entry_type'] ||
      !entry['cite_key'] ||
      !entry['author'] ||
      !entry['title'] ||
      !entry['journal'] ||
      !entry['year'] ||
      !entry['volume']
    true
  end
end

