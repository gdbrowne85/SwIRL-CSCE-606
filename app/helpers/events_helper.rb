# app/helpers/events_helper.rb
require 'time'

module EventsHelper
    def self.print_reminder_time(event)
        if event.present? && event.reminder_time.present?
            reminder_time = event.reminder_time
            current_time = Time.now
            time_difference = reminder_time - current_time
            formatted_time_difference = EventsHelper.format_time_difference(time_difference)
            formatted_reminder_time = reminder_time.strftime("%H:%M:%S")
            puts "The time", formatted_time_difference
            # return "<h3>Entered Here</h3>".html_safe
            # return "<h3>Reminder Time: #{formatted_reminder_time} (#{formatted_time_difference})</h3>".html_safe
            return formatted_time_difference
        else
            return "<h3>No reminder time set</h3>".html_safe
        end
    end
  
    # Helper function to format the time difference
    def self.format_time_difference(time_difference)
        seconds = time_difference.abs
        hours = seconds / 3600
        minutes = (seconds % 3600) / 60
        seconds = seconds % 60
        formatted_difference = sprintf("%02d:%02d:%02d", hours, minutes, seconds)
        time_difference.negative? ? "-#{formatted_difference}" : "+#{formatted_difference}"
        end
    end
  