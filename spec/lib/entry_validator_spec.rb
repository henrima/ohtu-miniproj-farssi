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

  it 'requires an entry type' do
    article_entry['entry_type'] = nil
    expect(EntryValidator.validate article_entry).to eq false
  end

  it 'requires a cite key' do
    article_entry['cite_key'] = nil
    expect(EntryValidator.validate article_entry).to eq false
  end

  describe 'article' do
    it 'validates a correct article class' do
      expect(EntryValidator.validate article_entry).to eq true
    end

    it 'requires author' do
      article_entry['author'] = nil
      expect(EntryValidator.validate article_entry).to eq false
    end

  end
end

