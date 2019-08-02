class IncidentMailer < ApplicationMailer
    def added_to_incident(user, incident)
        @user, @incident = user, incident
        mail(to: @user.email, subject: "You were added to incident '#{@incident}'")
    end
end
