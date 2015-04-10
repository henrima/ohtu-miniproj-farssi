require 'rails_helper'
require 'entry_validator'

RSpec.describe 'EntryValidator' do
  let(:article_entry) { {
    'entry_type' => 'article',
    'cite_key' => 'art1',
    'author' => 'Arttu Authori',
    'title' => 'Article Title',
    'journal' => 'The Journal',
    'year' => '1922',
    'volume' => '3b',
    'number' => '8',
    'pages' => '24--9283',
    'month' => 'June',
    'note' => 'Some result it is!',
  } }

  # TODO: refactor using meta-programming?
  it 'requires an article entry' do
    require_field article_entry, 'entry_type'
  end

  it 'requires a cite key' do
    require_field article_entry, 'cite_key'
  end

  describe 'article' do
    it 'validates a correct article class' do
      expect(EntryValidator.validate article_entry).to eq true
    end

    it 'requires author' do
      require_field article_entry, 'author'
    end
  end


  private

    def require_field(entry, field)
      entry[field] = nil
      expect(EntryValidator.validate entry).to eq false
    end
end

