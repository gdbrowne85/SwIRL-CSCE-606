Given('the user is on the series event page') do
    visit('/series') # Path for the series event page
  end
  
When('the user fills in the series event form with the following details:') do |table|
    data = table.rows_hash
    fill_in 'Event Name', with: data['Event Name']
    fill_in 'Event Venue', with: data['Event Venue']
    fill_in 'event[time_slots_attributes][0][date]', with: data['Date']
    fill_in 'event[time_slots_attributes][0][start_time]', with: data['Start Time']
    fill_in 'event[time_slots_attributes][0][end_time]', with: data['End Time']
end

When('the user uploads a csv file') do
    # Assuming 'path_to_csv' is the path to your CSV file

    path_to_csv = './features/step_definitions/files/Test.csv'
    attach_file('event[csv_file]', path_to_csv) # 'Choose File' is the name of the input field for file upload
end

When('the user submits the series event form') do
    click_button('Submit') # Adjust this if your submit button has a different name or text
end

Then('the user should see the following series event details:') do |table|
    table.rows_hash.each do |_field, value|
      expect(page).to have_content(value)
    end
  end
  
