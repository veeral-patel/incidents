class MentionMailer < ApplicationMailer
    def mentioned_in_incident_description(user, incident)
        @user, @incident = user, incident
        mail(to: @user.email, subject: "You were mentioned in incident '#{@incident}'")
    end

    def mentioned_in_ticket_description(user, ticket)
        @user, @ticket = user, ticket
        mail(to: @user.email, subject: "You were mentioned in ticket '#{@ticket}'")
    end
end
