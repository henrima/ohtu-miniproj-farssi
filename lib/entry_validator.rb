# TODO: crossref field is special (always allowed?)
# TODO: eg. book class has required author OR editor


module EntryValidator
  def EntryValidator.all_fields
    ['address',       # Publisher's address (usually just the city, but can be the full address for lesser-known publishers)
     'annote',        # An annotation for annotated bibliography styles (not typical)
     'author',        # The name(s) of the author(s) (in the case of more than one author, separated by and
     'booktitle',     # The title of the book, if only part of it is being cited
     'chapter',       # The chapter number
     'crossref',      # The key of the cross-referenced entry
     'edition',       # The edition of a book, long form (such as "First" or "Second")
     'editor',        # The name(s) of the editor(s)
     'howpublished',  # How it was published, if the publishing method is nonstandard
     'institution',   # The institution that was involved in the publishing, but not necessarily the publisher
     'journal',       # The journal or magazine the work was published in
     'key',           # A hidden field used for specifying or overriding the alphabetical order of entries (when the "author" and "editor" fields are missing). Note that this is very different from the key (mentioned just after this list) that is used to cite or cross-reference the entry.
     'month',         # The month of publication (or, if unpublished, the month of creation)
     'note',          # Miscellaneous extra information
     'number',        # The "(issue) number" of a journal, magazine, or tech-report, if applicable. (Most publications have a "volume", but no "number" field.)
     'organization',  # The conference sponsor
     'pages',         # Page numbers, separated either by commas or double-hyphens.
     'publisher',     # The publisher's name
     'school',        # The school where the thesis was written
     'series',        # The series of books the book was published in (e.g. "The Hardy Boys" or "Lecture Notes in Computer Science")
     'title',         # The title of the work
     'type',          # The field overriding the default type of publication (e.g. "Research Note" for techreport, "{PhD} dissertation" for phdthesis, "Section" for inbook/incollection)
     'volume',        # The volume of a journal or multi-volume book
     'year',          # The year of publication (or, if unpublished, the year of creation)
    ]
  end

  def EntryValidator.field_db 
      {
        'ARTICLE' => ['author', 'title', 'journal', 'year', 'volume',
                        'number', 'pages', 'month', 'note', 'key'],
        'BOOK' => ['author/editor', 'title', 'publisher', 'year',
                         'volume/number', 'series', 'address', 'edition', 'month', 'note', 'key'],
        'BOOKLET' => ['title', 
                         'author', 'howpublished', 'address', 'month', 'year', 'note', 'key'],
        'CONFERENCE' => ['author', 'title', 'booktitle', 'year', 
                         'editor', 'volume/number', 'series', 'pages', 'address', 'month', 'organization', 'publisher', 'note', 'key'],
        'INBOOK' => ['author/editor', 'title', 'chapter/pages', 'publisher', 'year',
                          'volume/number', 'series', 'type', 'address', 'edition', 'month', 'note', 'key'],
        'INPROCEEDINGS' => ['author', 'title', 'booktitle', 'year', 
                         'editor', 'volume/number', 'series', 'pages', 'address', 'month', 'organization', 'publisher', 'note', 'key'],
        'MANUAL' => ['title',
                          'author', 'organization', 'address', 'edition', 'month', 'year', 'note', 'key'],
        'MASTERSTHESIS' => ['author', 'title', 'school', 'year',
                          'type', 'address', 'month', 'note', 'key'],
        'MISC' => ['none',
                           'author', 'title', 'howpublished', 'month', 'year', 'note', 'key'],
        'PHDTHESIS' => ['author', 'title', 'school', 'year',
                           'type', 'address', 'month', 'note', 'key'],
        'PROCEEDINGS' => ['title', 'year',
                           'editor', 'volume/number', 'series', 'address', 'month', 'publisher', 'organization', 'note', 'key'],
        'TECHREPORT' => ['author', 'title', 'institution', 'year',
                           'type', 'number', 'address', 'month', 'note', 'key'],
        'UNPUBLISHED' => ['author', 'title', 'note',
                           'month', 'year', 'key'],
      }
    }
  end

  def EntryValidator.validate entry
 #   return false if entry['entry_type'].nil?
 #   return false if entry['cite_key'].nil?

 #   return false if not field_db.keys.include? entry['entry_type']
 #   fields = field_db[entry['entry_type']]
    
 #   # check that required fields are present
 #   fields['required'].each do |field|
 #     return false if entry[field].nil?
 #   end

 #   all_fields = fields.values.flatten
    # check that only required/optional fields are present
 #   entry.each do |key, value|
 #     if not (key == 'entry_type' or key == 'cite_key') then
 #       return false if not fields.keys.include?(key) and not value.nil?
 #     end
 #   end

    return true
  end
end

