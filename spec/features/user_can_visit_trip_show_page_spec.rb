require 'rails_helper'

describe 'as a visitor' do
  describe 'can click to on a trip' do
    before(:each) do
      @trip_1 = Trip.create(name: "trip_1", start_date: 2.days, end_date: 5.days)
      @trail_1 = Trail.create(name: 'trail_1', address: '123 st', length: 2)
      @trail_2 = Trail.create(name: 'trail_2', address: '456 st', length: 3)
      @trail_3 = Trail.create(name: 'trail_3', address: '789 st', length: 4)
      @trip_1.trails << [@trail_1, @trail_2, @trail_3]
    end

    it 'can see a trip show page' do

      visit trips_path
      click_link "#{@trip_1.name}"

      expect(current_path).to eq(trip_path(@trip_1))
    end

    it 'shows a list of trails' do

      visit trip_path(@trip_1)

      expect(page).to have_content(@trail_1.name)
      expect(page).to have_content(@trail_1.address)
      expect(page).to have_content(@trail_1.length)
      expect(page).to have_content(@trail_2.name)
      expect(page).to have_content(@trail_2.address)
      expect(page).to have_content(@trail_2.length)
      expect(page).to have_content(@trail_3.name)
      expect(page).to have_content(@trail_3.address)
      expect(page).to have_content(@trail_3.length)
    end

    it 'has a total hiking distance' do
      visit trip_path(@trip_1)

      expect(page).to have_content("Total Distance: 9")
    end

    it 'has an average hiking distance' do
      visit trip_path(@trip_1)

      expect(page).to have_content("Average Distance: 3")
    end

    it 'shows longest hiking distance' do
      visit trip_path(@trip_1)

      expect(page).to have_content("Longest Hiking Distance: #{@trail_3.length}")
    end

    it 'shows shortest hiking distance' do
      visit trip_path(@trip_1)

      expect(page).to have_content("Shortest Hiking Distance: #{@trail_1.length}")
    end
  end
end
