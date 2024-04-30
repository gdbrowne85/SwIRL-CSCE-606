# frozen_string_literal: true

require 'signet'

class CalendarsController < ApplicationController
  def redirect
    client = Signet::OAuth2::Client.new(client_options)
    redirect_to(client.authorization_uri.to_s, allow_other_host: true)
  end

  def callback
    client = Signet::OAuth2::Client.new(client_options)
    client.code = params[:code]

    response = client.fetch_access_token!

    session[:authorization] = response

    redirect_to eventdashboard_path
  end

  def create_event
    @event = Event.find(params[:id])
    @event_info = @event.event_info

    if authorized?
      begin
        client = Signet::OAuth2::Client.new(client_options)
        client.update!(session[:authorization])

        service = Google::Apis::CalendarV3::CalendarService.new
        service.authorization = client

        Date.today
        if @event.time_slots.present?
          @event.time_slots.each do |time_slot|
            start_datetime = DateTime.parse("#{time_slot.date}T#{time_slot.start_time}:00").strftime('%Y-%m-%dT%H:%M:%S.%LZ')
            end_datetime = DateTime.parse("#{time_slot.date}T#{time_slot.end_time}:00").strftime('%Y-%m-%dT%H:%M:%S.%LZ')

            new_event = Google::Apis::CalendarV3::Event.new(
              start: Google::Apis::CalendarV3::EventDateTime.new(date_time: start_datetime),
              end: Google::Apis::CalendarV3::EventDateTime.new(date_time: end_datetime),
              location: @event_info.venue,
              summary: @event_info.name
            )

            if @event.attendee_infos.present?
              attendees = []
              @event.attendee_infos.each do |attendee_info|
                attendees << Google::Apis::CalendarV3::EventAttendee.new(email: attendee_info.email,
                                                                         display_name: attendee_info.name, response_status: attendee_info.is_attending == 'yes' ? 'accepted' : 'needsAction')
              end
              new_event.attendees = attendees
            end
    
            calendar_id = params[:calendar_id] || 'primary'
            service.insert_event(calendar_id, new_event)
    
            flash[:notice] = 'Series event added successfully!'
          end
        else 
          start_datetime = DateTime.parse("#{@event_info.date}T#{@event_info.start_time}:00").strftime('%Y-%m-%dT%H:%M:%S.%LZ')
          end_datetime = DateTime.parse("#{@event_info.date}T#{@event_info.end_time}:00").strftime('%Y-%m-%dT%H:%M:%S.%LZ')

          new_event = Google::Apis::CalendarV3::Event.new(
            start: Google::Apis::CalendarV3::EventDateTime.new(date_time: start_datetime),
            end: Google::Apis::CalendarV3::EventDateTime.new(date_time: end_datetime),
            location: @event_info.venue,
            summary: @event_info.name
          )

          if @event.attendee_infos.present?
            attendees = []
            @event.attendee_infos.each do |attendee_info|
              attendees << Google::Apis::CalendarV3::EventAttendee.new(email: attendee_info.email,
                                                                      display_name: attendee_info.name, response_status: attendee_info.is_attending == 'yes' ? 'accepted' : 'needsAction')
            end
            new_event.attendees = attendees
          end

          calendar_id = params[:calendar_id] || 'primary'
          service.insert_event(calendar_id, new_event)

          flash[:notice] = 'Event added successfully!'
        end 
        redirect_to eventdashboard_path

      rescue Google::Apis::Error
        redirect_to redirect_path
      end
    else
      redirect_to redirect_path
      nil
    end
  end

  private

  def authorized?
    session[:authorization].present?
  end

  def client_options
    {
      client_id: '54273617703-87bsbouu3r31ga09apt4ihqs8pli2v0c.apps.googleusercontent.com',
      client_secret: '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',
      authorization_uri: 'https://accounts.google.com/o/oauth2/auth',
      token_credential_uri: 'https://oauth2.googleapis.com/token',
      scope: Google::Apis::CalendarV3::AUTH_CALENDAR,
      redirect_uri: callback_url
    }
  end
end
