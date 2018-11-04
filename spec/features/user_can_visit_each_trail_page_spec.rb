require 'rails_helper'

describe 'a visiter can visit a trail page' do
  it 'shows an individual trail' do
    @trip_1 = Trip.create(name: "trip_1", start_date: 2.days, end_date: 5.days)
    @trail_1 = Trail.create(name: 'trail_1', address: '123 st', length: 2)
    @trip_1.trails << @trail_1

    visit trip_path(@trip_1)

    click_link @trail_1.name

    expect(current_path).to eq(trail_path(@trail_1))
  end

  it 'shows trail info' do
    @trip_1 = Trip.create(name: "trip_1", start_date: 2.days, end_date: 5.days)
    @trip_2 = Trip.create(name: "trip_2", start_date: 3.days, end_date: 4.days)
    @trip_3 = Trip.create(name: "trip_3", start_date: 1.days, end_date: 2.days)
    @trail_1 = Trail.create(name: 'trail_1', address: '123 st', length: 2)
    @trail_2 = Trail.create(name: 'trail_2', address: '456 st', length: 3)
    @trip_1.trails << [@trail_1, @trail_2]
    @trip_2.trails << @trail_1
    @trip_3.trails << @trail_2

    visit trail_path(@trail_1)

    expect(page).to have_content(@trail_1.name)
    expect(page).to have_content(@trail_1.address)
    expect(page).to have_content(@trip_1.name)
    expect(page).to have_content(@trip_1.total_distance)
    expect(page).to have_content(@trip_2.name)
    expect(page).to have_content(@trip_2.total_distance)

    expect(page).not_to have_content(@trip_3.name)
  end

  it 'shows total trips that use the trail' do
    @trip_1 = Trip.create(name: "trip_1", start_date: 2.days, end_date: 5.days)
    @trip_2 = Trip.create(name: "trip_2", start_date: 3.days, end_date: 4.days)
    @trip_3 = Trip.create(name: "trip_3", start_date: 1.days, end_date: 2.days)
    @trail_1 = Trail.create(name: 'trail_1', address: '123 st', length: 2)
    @trip_1.trails << @trail_1
    @trip_2.trails << @trail_1
    @trip_3.trails << @trail_1

    visit trail_path(@trail_1)
    
    expect(page).to have_content("Total trips that include this trail: #{@trail_1.total_trips}")
  end
end
