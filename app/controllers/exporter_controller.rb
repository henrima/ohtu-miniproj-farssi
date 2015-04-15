class ExporterController < ApplicationController


  def index
  end

  def export
    # SAMPLE INPUT FOR GENERATE METHOD
    #input =   { "author" => "KÄa3ke", "title" => "Nykänen vankilassa", "journal" => "Seitsemän päivää",
    #           "year" => "2014", "volume" => "asdasd", "number" => "34", "pages" => "13-14", "month" => "feb",
    #           "crossref" => "KB1", "note" => "hienoa"}
    #generate("article", "KB1", input)

    string = ''

    entries = Entry.all
    entries.each do |e|
      input = {}
      key = ''

      fields = e.fields
      fields.each do |f|
        next if f.content == ''
        if f.name == 'key'
          key = f.content
        else
          input[f.name] = f.content
        end
      end
      category = e.category

      # alle input_to_s tilalle generate
      # string += generate(category, key, input)
      string += input.to_s
    end

    render plain: string
  end

  private

    def get_fields 
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
                      'required' => ['none'],
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

end
