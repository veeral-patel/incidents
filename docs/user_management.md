# User Management

To add/remove users, visit `Admin > Users` in the top navigation bar. (Only admins can access this page).

## Adding users

To add an user, enter her email address to send her an
invitation to create an account.

## Disabling users

- Currently, disabled users cannot be re-enabled. This will be fixed.
- You cannot disable the last enabled admin user.
- You cannot disable the last enabled user (who's probably an admin!).

## User statuses

An user can have a status of:

- **DISABLED**: User is soft deleted and cannot log in.
- **INVITATION_PENDING**: The user has been sent, but hasn't accepted, an invitation
- **INVITATION_ACCEPTED**: The user has been sent and has accepted an invitation
- **CREATED_MANUALLY**: This user wasn't created via invitation. This is likely the initial user, created using the Rails console.
