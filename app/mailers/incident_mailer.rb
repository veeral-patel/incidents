class IncidentMailer < ApplicationMailer
    def added_to_incident(user, incident)
        @user, @incident = user, incident
        mail(to: @user.email, subject: "You were added to incident '#{@incident}'")
    end
    
    def removed_from_incident(user, incident)
        @user, @incident = user, incident
        mail(to: @user.email, subject: "You were removed from incident '#{@incident}'")
    end

    def assigned_to_incident(user, incident)
        @user, @incident = user, incident
        mail(to: @user.email, subject: "You were assigned incident #{@incident}")
    end
end
