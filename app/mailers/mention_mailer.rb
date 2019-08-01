class MentionMailer < ApplicationMailer
    def mentioned_in_incident_description(user, incident)
        @user, @incident = user, incident
        mail(to: @user.email, subject: "You were mentioned in incident '#{@incident}'")
    end

    def mentioned_in_ticket_description(user, ticket)
        @user, @ticket = user, ticket
        mail(to: @user.email, subject: "You were mentioned in ticket '#{@ticket}'")
    end

    def mentioned_in_observable_description(user, observable)
        @user, @observable = user, observable
        mail(to: @user.email, subject: "You were mentioned in observable '#{@observable}'")
    end

    def mentioned_in_ticket_comment(user, comment)
        @user, @comment = user, comment
        mail(to: @user.email, subject: "#{@comment.user} mentioned you in a comment on ticket '#{comment.ticket}'")
    end
end
