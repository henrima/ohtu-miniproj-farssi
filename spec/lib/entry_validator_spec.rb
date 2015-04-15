require 'rails_helper'
require 'entry_validator'

RSpec.describe 'EntryValidator' do
  let(:article_entry) { Entry.new(category:'ARTICLE') }
  let(:article_params) { {
    #'cite_key' => 'art1',
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
    let(:params) { {"utf8"=>"✓", "authenticity_token"=>"BFds41XVUHZoQTTeSkkB2/p7XTUodkLBBIP3/1nAv5/1oI5JhqI2TXQw2H0R3KKQ2l1EmrZIkbRwJG+mT1ic8A==", "entry"=>{"category"=>"ARTICLE"}, "author"=>{"content"=>"a"}, "title"=>{"content"=>"b"}, "journal"=>{"content"=>"c"}, "year"=>{"content"=>"d"}, "volume"=>{"content"=>"e"}, "number"=>{"content"=>"f"}, "pages"=>{"content"=>"g"}, "month"=>{"content"=>"h"}, "note"=>{"content"=>"i"}, "key"=>{"content"=>"j"}, "commit"=>"Create Entry"} }

    it 'does the right thing' do
      expected = { "author"=>"a", "title"=>"b", "journal"=>"c", "year"=>"d", "volume"=>"e", "number"=>"f", "pages"=>"g", "month"=>"h", "note"=>"i", "key"=>"j" }
      expect(EntryValidator.clean_params 'ARTICLE', params).to eq expected
    end
  end

  describe 'article' do
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

    describe 'does not allow nonrequired-nonoptional field' do
      allfields = EntryValidator.all_fields
      fields = EntryValidator.field_db['ARTICLE'].values.flatten
      (allfields - fields).each do |field|
        it field do
          do_not_allow article_entry, article_params, field
        end
      end
    end
  end


  private

    def require_field(entry, params, field)
      params[field] = nil
      expect(EntryValidator.validate entry, params).to eq false
    end

    def do_not_require(entry, params, field)
      params[field] = nil
      expect(EntryValidator.validate entry, params).to eq true
    end

    def do_not_allow(entry, params, field)
      params[field] = 'hello'
      expect(EntryValidator.validate entry, params).to eq false
    end
end

