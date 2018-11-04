require 'rails_helper'

describe 'as a visiter' do
  describe 'visit the trip index page' do
    it 'sees a list of all trip names' do
      trip_1 = Trip.create(name: "trip_1", start_date: 2.days, end_date: 5.days)
      trip_2 = Trip.create(name: "trip_2", start_date: 2.days, end_date: 5.days)
      trip_3 = Trip.create(name: "trip_3", start_date: 2.days, end_date: 5.days)

      visit trips_path

      expect(current_path).to eq(trips_path)
      expect(page).to have_content(trip_1.name)
      expect(page).to have_content(trip_2.name)
      expect(page).to have_content(trip_3.name)
    end
  end
end
