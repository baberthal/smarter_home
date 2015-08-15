require 'spec_helper'
require 'shared/decorator_shared_spec'

RSpec.describe Services::Nest::Decorators::Device do
  it_behaves_like 'a decorator', described_class
end
