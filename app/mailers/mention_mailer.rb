class MentionMailer < ApplicationMailer
    def mentioned_in_incident_description(user, incident)
        @user, @incident = user, incident
        mail(to: @user.email, subject: "You were mentioned in incident '#{@incident}'")
    end
end
