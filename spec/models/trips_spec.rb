require 'rails_helper'

describe Trip, type: :model do
  describe 'relationships' do
    it {should have_many :trip_trails}
    it {should have_many(:trails).through(:trip_trails)}
  end

  describe 'instance methods' do
    before(:each) do
      @trip_1 = Trip.create(name: "trip_1", start_date: 2.days, end_date: 5.days)
      @trail_1 = Trail.create(name: 'trail_1', address: '123 st', length: 2)
      @trail_2 = Trail.create(name: 'trail_2', address: '456 st', length: 3)
      @trail_3 = Trail.create(name: 'trail_3', address: '789 st', length: 4)
      @trip_1.trails << [@trail_1, @trail_2, @trail_3]
    end

    it '.total_distance' do
      expect(@trip_1.total_distance).to eq(9)
    end

    it '.average_distance' do
      expect(@trip_1.average_distance).to eq(3)
    end

    it '.longest_distance' do
      expect(@trip_1.longest_distance).to eq(4)
    end

    it '.shortest_distance' do
      expect(@trip_1.shortest_distance).to eq(2)
    end

  end
end
