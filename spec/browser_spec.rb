require 'browser'

RSpec.describe Browser, 'in terms of the' do
  context 'class GeneratedList' do
    it 'the value of is_browser? should equal true' do
      expect(Browser.new.is_browser?).to eq true
    end
  end
end