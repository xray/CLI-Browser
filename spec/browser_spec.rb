require 'browser'

RSpec.describe Browser, 'in terms of the' do
  context 'class GeneratedList' do
    it 'the value of browser? should equal true' do
      expect(Browser.new.browser?).to eq true
    end
  end
end
