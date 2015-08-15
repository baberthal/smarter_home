require 'spec_helper'
require 'shared/decorator_shared_spec'

RSpec.describe Services::Nest::Decorators::Structure do
  it_behaves_like 'a decorator', described_class

  describe 'individual methods' do
    let(:structure) { instance_double('Services::Nest::Structure') }
    let(:example_stats) do
      {
        'thermostats': ['peyiJNo0IldT2YlIVtYaGQ'],
        'smoke_co_alarms': ['RTMTKxsQTCxzVcsySOHPxKoF4OyCifrs'],
        'away': 'home',
        'name': 'Home',
        'country_code': 'US',
        'postal_code': '94304',
        'peak_period_start_time': '2015-10-31T23:59:59.000Z',
        'peak_period_end_time': '2015-10-31T23:59:59.000Z',
        'time_zone': 'America/Los_Angeles',
        'eta': {
          'trip_id': 'myTripHome1024',
          'estimated_arrival_window_begin': '2015-10-31T22:42:59.000Z',
          'estimated_arrival_window_end': '2015-10-31T23:59:59.000Z'
        },
        'wheres': {
          'Fqp6wJI...': {
            'where_id': 'Fqp6wJI...',
            'name': 'Bedroom'
          }
        }
      }
    end

    let(:decorator) { described_class.new(structure) }

    before :each do
      allow(structure).to receive(:name).and_return('Test Home1')
      allow(structure).to receive(:away).and_return('home')
      allow(structure).to receive(:stats).and_return(example_stats)
    end

    describe '#name' do
      it 'returns the structures name' do
        expect(decorator.name).to eq 'Test Home1'
      end
    end

    describe '#html_id' do
      it 'returns the parameterized name' do
        expect(decorator.html_id).to eq 'test-home1'
      end
    end

    describe '#away_header' do
      it 'returns the proper away header' do
        expect(decorator.away_header).to match(/id='home'/)
      end
    end

    describe 'wheres' do
      it 'returns the wheres' do
        expect(decorator.wheres).to eq example_stats['wheres']
      end
    end
  end
end
