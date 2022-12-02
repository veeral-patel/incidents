# Overview

INCIDENTS is an open source web application for incident response, just like [TheHive](https://thehive-project.org).

## Investigations are tree-like

Investigations are tree-like: a piece of malware may spawn an enterprise-wide sweep, which may find another
piece of malware, which may spawn another sweep, and so on.

But existing ticketing systems, like TheHive and JIRA, don't let you create subtickets of subtickets.

_INCIDENTS models incidents as a tree of tickets, like this:_

![Tree](img/tree.png)

## Concepts

- Create an **incident** for each investigation
- Each incident has many **tickets**, or pieces of work.
- If a ticket needs to be investigated further, mark it as a **lead**.
- Add **comments**, **attachments**, and **observables** (aka indicators) to a ticket.
- Add **child tickets** to a ticket to break it down into smaller pieces, or to indicate the ticket spawned another piece of work.

## Benefits

- **Avoid missing things with centralized lead management**--whether you're
  analysing a single system or leading a large engagement
- **Keep people on the same page**--team members can glance at the tree to find out what's going on, instead of reading old status updates or reading the entire Slack channel
- **Complete investigations faster**--divide large tasks into smaller
  tickets you assign to people to get things done in parallel. And analysts can identify open tickets to work on, without waiting for the investigation lead
- **Preserve institutional knowledge**--document how investigations developed over time to reference in future incidents and for training new analysts
- **Improve your IR process**--by documenting an investigation's evolution, be able to look back and find bottlenecks, areas for improvement, opportunities for automation
- **Tame incidents with large scopes**--people only need to worry about the few levels in the tree below theirs, instead of being exposed to all the information about the incident

## Features

- Restrict who can view an incident
- View all an incident's files/observables/leads in one place
- Drag/drop nodes in the tree to quickly reorganize an incident
- Tag indicators, attachments, tickets, and incidents
- Comment on tickets
- Assign tickets, incidents to users
- Assign statuses and priorities to tickets
- Keyboard shortcuts for creating an incident, search

## FAQ

### Who's behind this project?

I'm [Veeral Patel](https://veeral-patel.com). I graduated from UC Berkeley with a Computer Science degree in 2018, interned at Yelp in college, and worked at Mandiant as an incident response consultant in SF after graduating.

Don't hesitate to email me at [veeral.patel@berkeley.edu](mailto:veeral.patel@berkeley.edu) with questions or feature requests! I respond to all emails, and most within a couple hours.
