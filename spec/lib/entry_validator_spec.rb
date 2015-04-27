require 'rails_helper'
require 'entry_validator'

RSpec.describe 'EntryValidator' do
  let(:article_entry) { Entry.new(category:'ARTICLE', cite_key:'art1') }
  let(:article_params) { {
    'author' => 'Arttu Authori',
    'title' => 'Article Title',
    'journal' => 'The Journal',
    'year' => '1922',
    'volume' => '3b',
    'number' => '8',
    'pages' => '24--9283',
    'month' => 'June',
    'note' => 'Some result it is!',
    'key' => 'Arttu Authori',
  } }

  let(:book_entry) { Entry.new(category:'BOOK', cite_key:'bk2') }
  let(:book_params) { {
    'author' => 'Arttu Authori',
    'title' => 'Article Title',
    'publisher' => 'The Pub',
    'year' => '1922',
    'volume' => '3b',
    'series' => '8',
    'address' => '24--9283',
    'edition' => 'June',
    'month' => 'Some result it is!',
    'note' => 'Nootti',
    'key' => 'Arttu Authori',
  } }

  # TODO: refactor using meta-programming?
  #it 'requires an entry type' do
  #  require_field article_entry, 'entry_type'
  #end
#
  #it 'requires a cite key' do
  #  require_field article_entry, 'cite_key'
  #end
  #
  describe 'clean_params' do
    let(:params) { {"utf8"=>"✓", "authenticity_token"=>"BFds41XVUHZoQTTeSkkB2/p7XTUodkLBBIP3/1nAv5/1oI5JhqI2TXQw2H0R3KKQ2l1EmrZIkbRwJG+mT1ic8A==", "entry"=>{"category"=>"ARTICLE", "cite_key"=>"cit"}, "author"=>{"content"=>"a"}, "title"=>{"content"=>"b"}, "journal"=>{"content"=>"c"}, "year"=>{"content"=>"d"}, "volume"=>{"content"=>"e"}, "number"=>{"content"=>"f"}, "pages"=>{"content"=>"g"}, "month"=>{"content"=>"h"}, "note"=>{"content"=>"i"}, "key"=>{"content"=>"j"}, "commit"=>"Create Entry"} }

    it 'does the right thing' do
      expected = { "author"=>"a", "title"=>"b", "journal"=>"c", "year"=>"d", "volume"=>"e", "number"=>"f", "pages"=>"g", "month"=>"h", "note"=>"i", "key"=>"j" }
      expect(EntryValidator.clean_params 'ARTICLE', params).to eq expected
    end
  end

  describe 'for article class' do
    it 'requires a valid category' do
      article_entry.category = 'invalid'
      expect(EntryValidator.validate article_entry, article_params).to eq false
    end

    it 'requires a cite_key' do
      article_entry.cite_key = '  '
      expect(EntryValidator.validate article_entry, article_params).to eq false
    end

    it 'validates a correct article class' do
      expect(EntryValidator.validate article_entry, article_params).to eq true
    end

    describe 'requires required field' do
      fields = EntryValidator.field_db['ARTICLE']['required']
      fields.each do |field|
        it field do
          require_field article_entry, article_params, field
        end
      end
    end

    describe 'does not require optional field' do
      fields = EntryValidator.field_db['ARTICLE']['optional']
      fields.each do |field|
        it field do
          do_not_require article_entry, article_params, field
        end
      end
    end
  end


  describe 'for book class' do
    it 'requires a valid category' do
      book_entry.category = 'invalid'
      expect(EntryValidator.validate book_entry, book_params).to eq false
    end

    it 'requires a cite_key' do
      book_entry.cite_key = '  '
      expect(EntryValidator.validate book_entry, book_params).to eq false
    end

    it 'validates a correct book class' do
      expect(EntryValidator.validate book_entry, book_params).to eq true
    end

    describe 'requires required field' do
      fields = EntryValidator.field_db['BOOK']['required']
      fields.each do |field|
        it field do
          require_field book_entry, book_params, field
        end
      end
    end

    describe 'does not require optional field' do
      fields = EntryValidator.field_db['BOOK']['optional']
      fields.each do |field|
        it field do
          do_not_require book_entry, book_params, field
        end
      end
    end

    describe 'only allows one of alternative pair' do
      pairs = EntryValidator.field_db['BOOK'].values.flatten.find_all{|f| f.include? '/'}
      pairs.each do |pair|
        it pair do
          pair.split('/').each do |field|
            book_params[field] = 'something'
          end
          expect(EntryValidator.validate book_entry, book_params).to eq false
        end
      end
    end
  end


  private

    def require_field(entry, params, field)
      field.split('/').each do |subfield|
        params[subfield] = ' '
      end
      expect(EntryValidator.validate entry, params).to eq false
    end

    def do_not_require(entry, params, field)
      field.split('/').each do |subfield|
        params[subfield] = ' '
      end
      expect(EntryValidator.validate entry, params).to eq true
    end

#    def do_not_allow(entry, params, field)
#      params[field] = 'hello'
#      expect(EntryValidator.validate entry, params).to eq false
#    end
end

