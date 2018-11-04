require 'rails_helper'

describe Trail, type: :model do
  describe 'validations' do
    it { should validate_presence_of :length }
    it { should validate_presence_of :name }
    it { should validate_presence_of :address }

    it { should validate_numericality_of(:length).only_integer }
    it { should validate_numericality_of(:length).is_greater_than(0) }
  end

  describe 'relationships' do
    it {should have_many :trip_trails}
    it {should have_many(:trips).through(:trip_trails)}
  end

  describe 'instance methods' do
    it '.total_trips' do
      @trip_1 = Trip.create(name: "trip_1", start_date: 2.days, end_date: 5.days)
      @trip_2 = Trip.create(name: "trip_2", start_date: 3.days, end_date: 4.days)
      @trip_3 = Trip.create(name: "trip_3", start_date: 1.days, end_date: 2.days)
      @trail_1 = Trail.create(name: 'trail_1', address: '123 st', length: 2)
      @trip_1.trails << @trail_1
      @trip_2.trails << @trail_1
      @trip_3.trails << @trail_1

      expect(@trail_1.total_trips).to eq(3)
    end
  end
end
