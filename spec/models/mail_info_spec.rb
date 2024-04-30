# frozen_string_literal: true

# spec/controllers/events_controller_spec.rb

require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  describe 'GET #invite_attendees' do
    it 'sends email invitations to all attendees' do
      event = Event.create(name: 'Sample Event') # Create a sample event
      event_info = EventInfo.create(event:, max_capacity: 10)
      AttendeeInfo.create(email: 'attendee1@example.com', event:, email_token: 'token1')
      AttendeeInfo.create(email: 'attendee2@example.com', event:, email_token: 'token2')

      allow_any_instance_of(Event).to receive(:event_info).and_return(event_info)

      expect(EventRemainderMailer).to receive(:with).exactly(2).times.and_return(EventRemainderMailer)
      expect(EventRemainderMailer).to receive(:reminder_email).exactly(2).times.and_return(double(deliver: true))

      controller.invite_attendees(event.id)
    end

    it 'sends email invitations to a limited number of attendees when at max capacity' do
      event = Event.create(name: 'Sample Event')
      event_info = EventInfo.create(event:, max_capacity: 5)
      (1..8).each do |i|
        AttendeeInfo.create(email: "attendee#{i}@example.com", event:, email_token: "token#{i}")
      end

      allow_any_instance_of(Event).to receive(:event_info).and_return(event_info)

      expect(EventRemainderMailer).to receive(:with).exactly(5).times.and_return(EventRemainderMailer)
      expect(EventRemainderMailer).to receive(:reminder_email).exactly(5).times.and_return(double(deliver: true))

      controller.invite_attendees(event.id)
    end

    it 'redirects to eventdashboard_path' do
      event = Event.create(name: 'Sample Event') # Create a sample event
      event_info = EventInfo.create(event:, max_capacity: 10)
      allow_any_instance_of(Event).to receive(:event_info).and_return(event_info)
      controller.invite_attendees(event.id)
    end
  end
end
