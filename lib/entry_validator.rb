module EntryValidator
  fields = {
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

