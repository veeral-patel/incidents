class TicketMailer < ApplicationMailer
    def assigned_to_ticket(user, ticket)
        @user, @ticket = user, ticket
        mail(to: @user.email, subject: "You were assigned to ticket '#{@ticket}'")
    end
end
