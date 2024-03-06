# lib/tasks/print_reminder_times.rake
namespace :event do
    task :print_reminder_times => :environment do
      Event.all.each do |event|
        EventsHelper.print_reminder_time(event.event_info)
      end
    end
  end
  