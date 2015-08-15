require 'rails_helper'

class DummyToDecorate
  def a_method
    'i am a method'
  end
end

RSpec.shared_examples 'a decorator' do |klass|
  let(:decorated) { DummyToDecorate.new }
  let(:decorator) { klass.new(decorated) }

  before :each do
    spy(decorated)
    allow(decorated).to receive(:a_method).and_call_original
  end

  it 'delegates defined missing methods to the decorated class' do
    expect(decorator.a_method).to eq 'i am a method'
  end

  it 'doesnt delegate methods that are not defined on the decorated class' do
    expect { decorator.another_method }.to raise_error NoMethodError
  end
end
