# TODO: crossref field is special (always allowed?)
# TODO: eg. book class has required author OR editor


module EntryValidator
  def EntryValidator.all_fields
    ['ADDRESS',       # Publisher's address (usually just the city, but can be the full address for lesser-known publishers)
     'ANNOTE',        # An annotation for annotated bibliography styles (not typical)
     'AUTHOR',        # The name(s) of the author(s) (in the case of more than one author, separated by and
     'BOOKTITLE',     # The title of the book, if only part of it is being cited
     'CHAPTER',       # The chapter number
     'CROSSREF',      # The key of the cross-referenced entry
     'EDITION',       # The edition of a book, long form (such as "First" or "Second")
     'EDITOR',        # The name(s) of the editor(s)
     'HOWPUBLISHED',  # How it was published, if the publishing method is nonstandard
     'INSTITUTION',   # The institution that was involved in the publishing, but not necessarily the publisher
     'JOURNAL',       # The journal or magazine the work was published in
     'KEY',           # A hidden field used for specifying or overriding the alphabetical order of entries (when the "author" and "editor" fields are missing). Note that this is very different from the key (mentioned just after this list) that is used to cite or cross-reference the entry.
     'MONTH',         # The month of publication (or, if unpublished, the month of creation)
     'NOTE',          # Miscellaneous extra information
     'NUMBER',        # The "(issue) number" of a journal, magazine, or tech-report, if applicable. (Most publications have a "volume", but no "number" field.)
     'ORGANIZATION',  # The conference sponsor
     'PAGES',         # Page numbers, separated either by commas or double-hyphens.
     'PUBLISHER',     # The publisher's name
     'SCHOOL',        # The school where the thesis was written
     'SERIES',        # The series of books the book was published in (e.g. "The Hardy Boys" or "Lecture Notes in Computer Science")
     'TITLE',         # The title of the work
     'TYPE',          # The field overriding the default type of publication (e.g. "Research Note" for techreport, "{PhD} dissertation" for phdthesis, "Section" for inbook/incollection)
     'VOLUME',        # The volume of a journal or multi-volume book
     'YEAR',          # The year of publication (or, if unpublished, the year of creation)
    ]
  end

  def EntryValidator.field_db 
      return {
        'ARTICLE' => {
                      'required' => ['author', 'title', 'journal', 'year', 'volume'],
                      'optional' => ['number', 'pages', 'month', 'note', 'key']
                      },
        'BOOK' =>    {
                      'required' => ['author/editor', 'title', 'publisher', 'year'],
                      'optional' => ['volume/number', 'series', 'address', 'edition', 'month', 'note', 'key']
                      },
        'BOOKLET' => {
                      'required' => ['title'], 
                      'optional' => ['author', 'howpublished', 'address', 'month', 'year', 'note', 'key']
                      },
        'CONFERENCE' => {
                      'required' => ['author', 'title', 'booktitle', 'year'], 
                      'optional' => ['editor', 'volume/number', 'series', 'pages', 'address', 'month', 'organization', 'publisher', 'note', 'key']
                      },
        'INBOOK' => {
                      'required' => ['author/editor', 'title', 'chapter/pages', 'publisher', 'year'],
                      'optional' => ['volume/number', 'series', 'type', 'address', 'edition', 'month', 'note', 'key']
                      },
        'INPROCEEDINGS' => {
                      'required' => ['author', 'title', 'booktitle', 'year'], 
                      'optional' => ['editor', 'volume/number', 'series', 'pages', 'address', 'month', 'organization', 'publisher', 'note', 'key']
                      },
        'MANUAL' => {
                      'required' => ['title'],
                      'optional' => ['author', 'organization', 'address', 'edition', 'month', 'year', 'note', 'key']
                      },
        'MASTERSTHESIS' => {
                      'required' => ['author', 'title', 'school', 'year'],
                      'optional' => ['type', 'address', 'month', 'note', 'key']
                      },
        'MISC' => {
                      'required' => [],
                      'optional' => ['author', 'title', 'howpublished', 'month', 'year', 'note', 'key']
                      },
        'PHDTHESIS' => {
                      'required' => ['author', 'title', 'school', 'year'],
                      'optional' => ['type', 'address', 'month', 'note', 'key']
                      },
        'PROCEEDINGS' => {
                      'required' => ['title', 'year'],
                      'optional' => ['editor', 'volume/number', 'series', 'address', 'month', 'publisher', 'organization', 'note', 'key']
                      },
        'TECHREPORT' => {
                      'required' => ['author', 'title', 'institution', 'year'],
                      'optional' => ['type', 'number', 'address', 'month', 'note', 'key']
                      },
        'UNPUBLISHED' => {
                      'required' => ['author', 'title', 'note'],
                      'optional' => ['month', 'year', 'key']
                      },

      }
  end

  def EntryValidator.clean_params(category, params)
    new_params = {}
    all_fields = field_db[category].values.flatten.map{|v| v.split('/')}.flatten
    params.each do |key, value|
      if all_fields.include?(key)
        new_params[key] = value['content']
      end
    end
    new_params
  end

  def EntryValidator.validate(entry, params)
    if not field_db.keys.include? entry.category
      entry.errors.add(:category, 'missing or invalid')
      return false
    end

    succeeds = true

    if entry.cite_key.blank?
      entry.errors.add(:cite_key, 'missing')
      succeeds = false
    end

    fields = field_db[entry.category]
    
    # check that required fields are present
    fields['required'].each do |field|
      onepresent = false
      field.split('/').each do |subfield|
        if not params[subfield].blank?
          onepresent = true
        end
      end
      if not onepresent
        entry.errors.add(field, 'missing')
        succeeds = false
      end
    end

    # check that at most one from an alternative pair is present
    pairs = fields.values.flatten.find_all{|f| f.include? '/'}
    pairs.each do |pair|
      onepresent = false
      pair.split('/').each do |field|
        if not params[field].blank?
          if not onepresent
            onepresent = true
          else
            entry.errors.add(field, 'at most one allowed')
            succeeds = false
          end
        end
      end
    end

#    all_fields = fields.values.flatten
#    # check that only required/optional fields are present
#    params.each do |key, value|
#      return false if not all_fields.include?(key) and not value.blank?
#    end

    return succeeds
  end
end

