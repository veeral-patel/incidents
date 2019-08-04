# INCIDENTS

[![Gitter](https://badges.gitter.im/incidents-oss/community.svg)](https://gitter.im/incidents-oss/community?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge)

INCIDENTS is a web-based, actively maintained case management tool for incident response, just like
[TheHive](https://thehive-project.org).

You can use INCIDENTS whether you're investigating a malware infection, a
phishing campaign, insider abuse, an application vulnerability, a
denial-of-service attempt, or any other kind of security incident.

If you work at a SOC, MSSP, incident response firm, or an internal
detection/response team, INCIDENTS is for you.

## Get INCIDENTS Running Locally

This script will install INCIDENTS, provision an initial user account for you, and print out the login credentials.

Docker and Docker Compose are required.

```
git clone https://github.com/veeral-patel/incidents && cd incidents
chmod +x install.sh && ./install.sh
```

Then visit http://localhost:80

**Don't run this setup in production!** Files are stored on disk, the database is not secured, and you won't be able to invite other users, as email sending hasn't been set up. Just use this setup to try out the tool.

### Dark theme

INCIDENTS supports a dark theme! See "Screenshots" at the bottom of this README to see some screenshots.

Instead of running the command above, run:

```
chmod +x install.sh && ./install.sh dark
```

## Why INCIDENTS?

Investigations are tree-like: a piece of malware may spawn an enterprise-wide sweep, which may find a related piece of malware, which may spawn
another sweep, and so on.

Unfortunately, existing ticketing systems -- like TheHive and JIRA -- don't let you create subtickets of subtickets. So effectively your
tree can only have 2 levels--and they don't show you a visualization of the tree, either.

INCIDENTS models an incident as a tree of tickets, with any number of levels.

![Tree](https://user-images.githubusercontent.com/12554095/62274952-b8c83a00-b3f5-11e9-8066-b864883b1979.png)

I believe this approach better captures an incident responder's mental model of
an incident.

## Benefits

- **Avoid missing things with centralized lead management**--whether you're analysing a single system or leading a large engagement
- **Keep people on the same page**--team members can glance at the tree to find out what's going on, instead of reading old status updates or reading the entire Slack channel
- **Complete investigations faster**--divide large tasks into smaller tickets you assign to people to get things done in parallel. And analysts can identify open tickets to work on, without waiting for the investigation lead
- **Preserve institutional knowledge**--document how investigations developed over time to reference in future incidents and for training new analysts
- **Improve your IR process**--by documenting an investigation's evolution, be able to look back and find bottlenecks, areas for improvement, opportunities for automation
- **Tame incidents with large scopes**--people only need to worry about the few levels in the tree below theirs, instead of being exposed to all the information about the incident

## Concepts

- Create an **incident** for each investigation
- Each incident has many **tickets**, or pieces of work.
- If a ticket needs to be investigated further, mark it as a **lead**.
- Add **comments**, **attachments**, and **observables** (aka indicators) to a ticket.
- Add **child tickets** to a ticket to break it down into smaller pieces, or to indicate the ticket spawned another piece of work.

## Features

- Restrict who can view an incident
- View all an incident's attachments in one place
- View all an incident's observables in one place
- View all an incident's leads in one place
- Drag/drop nodes in the tree to quickly reorganize an incident
- Tag indicators, attachments, tickets, and incidents
- Assign tickets to users
- Assign statuses and priorities to tickets
- Keyboard shortcut for creating an incident

## Tech Stack

INCIDENTS is built using:

- Ruby on Rails
- Bulma
- JQuery

## Get in Touch

To request a feature or report a bug, [please open an issue on GitHub](https://github.com/veeral-patel/incidents/issues)

You can email the author at [veeral.patel@berkeley.edu](mailto:veeral.patel@berkeley.edu). I reply to all emails, and most within a couple hours. I welcome feedback!

We're on [Gitter](https://gitter.im/incidents-oss/community), too.

## Screenshots

<p>
<img width="115" alt="all_incidents" src="https://user-images.githubusercontent.com/12554095/62274941-b7970d00-b3f5-11e9-85dd-a0ec255e938b.png">
<img width="124" alt="all_tickets" src="https://user-images.githubusercontent.com/12554095/62274942-b7970d00-b3f5-11e9-93d6-f8863aead33c.png">
<img width="124" alt="assigned_tickets" src="https://user-images.githubusercontent.com/12554095/62274944-b82fa380-b3f5-11e9-9c2c-02287c6c1dee.png">
<img width="123" alt="delete_incident" src="https://user-images.githubusercontent.com/12554095/62274945-b82fa380-b3f5-11e9-9eb4-b54059ac6dfb.png">
<img width="120" alt="incident_attachments" src="https://user-images.githubusercontent.com/12554095/62274946-b82fa380-b3f5-11e9-9428-3eca7f36f37d.png">
<img width="124" alt="incident_details" src="https://user-images.githubusercontent.com/12554095/62274947-b82fa380-b3f5-11e9-8c1a-446e91d6908f.png">
</p>
<p>
<img width="120" alt="incident_leads" src="https://user-images.githubusercontent.com/12554095/62274948-b82fa380-b3f5-11e9-9cba-56a90530a523.png">
<img width="124" alt="incident_members" src="https://user-images.githubusercontent.com/12554095/62274949-b8c83a00-b3f5-11e9-82ee-89ae29775bb7.png">
<img width="124" alt="incident_observables" src="https://user-images.githubusercontent.com/12554095/62274950-b8c83a00-b3f5-11e9-9f99-4f9a5b7701a5.png">
<img width="120" alt="incident_tickets" src="https://user-images.githubusercontent.com/12554095/62274951-b8c83a00-b3f5-11e9-9fbc-4cdc04feea01.png">
<img width="124" alt="incident_tree" src="https://user-images.githubusercontent.com/12554095/62274952-b8c83a00-b3f5-11e9-8066-b864883b1979.png">
<img width="124" alt="new_ticket" src="https://user-images.githubusercontent.com/12554095/62274953-b8c83a00-b3f5-11e9-94be-d1442bc1e7e4.png">
</p>
<p>
<img width="120" alt="new_incident" src="https://user-images.githubusercontent.com/12554095/62274954-b8c83a00-b3f5-11e9-8868-30dedbfdc9f4.png">
<img width="120" alt="ticket_tree" src="https://user-images.githubusercontent.com/12554095/62274955-b960d080-b3f5-11e9-9d20-e7c536935e84.png">
<img width="120" alt="ticket_comments" src="https://user-images.githubusercontent.com/12554095/62274956-b960d080-b3f5-11e9-935e-e726d0ff53dc.png">
<img width="120" alt="ticket_details" src="https://user-images.githubusercontent.com/12554095/62274957-b960d080-b3f5-11e9-94e5-d88bc3fd9191.png">
<img width="124" alt="search" src="https://user-images.githubusercontent.com/12554095/62274959-b960d080-b3f5-11e9-8cc3-2a414a5fff42.png">
<img width="124" alt="users" src="https://user-images.githubusercontent.com/12554095/62274960-b960d080-b3f5-11e9-81cf-d986344332e6.png">
</p>
<p>
<img width="118" alt="Screen Shot 2019-07-30 at 1 21 45 AM" src="https://user-images.githubusercontent.com/12554095/62276698-7b65ab80-b3f9-11e9-88b0-f6581d413dca.png">
<img width="116" alt="Screen Shot 2019-07-30 at 12 59 35 AM" src="https://user-images.githubusercontent.com/12554095/62276699-7b65ab80-b3f9-11e9-9c55-f14052b01130.png">
<img width="116" alt="Screen Shot 2019-07-30 at 12 59 50 AM" src="https://user-images.githubusercontent.com/12554095/62276700-7bfe4200-b3f9-11e9-967f-c5c9469a1f7f.png">
<img width="123" alt="Screen Shot 2019-08-01 at 1 11 16 AM" src="https://user-images.githubusercontent.com/12554095/62276701-7bfe4200-b3f9-11e9-85dc-85cd7cf18fe4.png">
<img width="123" alt="Screen Shot 2019-08-01 at 1 11 26 AM" src="https://user-images.githubusercontent.com/12554095/62276702-7bfe4200-b3f9-11e9-9b16-1685fbb85f29.png">
<img width="123" alt="Screen Shot 2019-08-01 at 1 11 40 AM" src="https://user-images.githubusercontent.com/12554095/62276703-7bfe4200-b3f9-11e9-8146-ae0d4e7aae72.png">
</p>
<p>
<img width="123" alt="Screen Shot 2019-08-01 at 1 12 00 AM" src="https://user-images.githubusercontent.com/12554095/62276704-7bfe4200-b3f9-11e9-8ddc-d445c289461b.png">
</p>
