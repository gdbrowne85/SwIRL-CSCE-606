# app/mailers/invitation_confirmation_mailer.rb
class RSVPConfirmationMailer < ApplicationMailer
    default from: 'SkheduleSp24@gmail.com'
    default_url_options[:host] = 'https://swirlskehdule-f316b598c688.herokuapp.com/'
  
    def acceptance_email(inviter_email, event_name)
      @inviter_email = inviter_email
      @event_name = event_name
  
      mail(to: @inviter_email, subject: 'Confirmation: User Joined Your Event')
    end

    def rejection_email(inviter_email, event_name)
        @inviter_email = inviter_email
        @event_name = event_name
    
        mail(to: @inviter_email, subject: 'Rejection: User Declined Your Event')
      end
  end
  