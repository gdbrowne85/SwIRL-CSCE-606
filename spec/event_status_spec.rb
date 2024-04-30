# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'EventStatus', type: :feature do
  before do
    Event.destroy_all
    EventInfo.destroy_all
    AttendeeInfo.destroy_all

    event = Event.create(name: 'Item 6')
    EventInfo.create(name: 'Item 6', description: 'event 6', date: DateTime.parse('26-May-2023'),
                     venue: 'Venue 6', start_time: Time.parse('00:00:00AM').in_time_zone('Central Time (US & Canada)'), end_time: Time.parse('06:00:00AM').in_time_zone('Central Time (US & Canada)'), event:)
    AttendeeInfo.create(name: 's1mple', email: 'example7@gmail.com', is_attending: 'no',
                        comments: 'N/A', event:)
    @events_im_hosting = Event.all

    visit eventdashboard_path
  end

  it 'displays event information' do
    # Simulate expanding the event details
    find('.event-header').click

    # Now check for the content
    expect(page).to have_content('Item 6')
    expect(page).to have_content('Venue 6')
    expect(page).to have_content('s1mple')
    expect(page).to have_content('example7@gmail.com')
  end
end
