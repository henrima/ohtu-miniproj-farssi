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

