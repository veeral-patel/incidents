# Dark Theme

INCIDENTS supports a dark theme. Unfortunately, everyone using the same installation
of INCIDENTS will see the same theme; there's no way at the moment for an user to set the
theme only for him.

## Installing INCIDENTS locally with a dark theme

Follow the standard installation instructions, but pass the `dark` parameter to
the install script:

```
git clone https://github.com/veeral-patel/incidents && cd incidents
chmod +x install.sh && sudo ./install.sh dark
```

**Don't run this setup in production!** The install script is just so you can start playing with INCIDENTS
locally. It's missing HTTPS and data and files are stored on disk.

## Screenshots

### Creating an incident

![](https://user-images.githubusercontent.com/12554095/62276699-7b65ab80-b3f9-11e9-9c55-f14052b01130.png)

### Viewing an incident's details

![](https://user-images.githubusercontent.com/12554095/62276700-7bfe4200-b3f9-11e9-967f-c5c9469a1f7f.png)

### Viewing a list of all incidents

![](https://user-images.githubusercontent.com/12554095/62276701-7bfe4200-b3f9-11e9-85dc-85cd7cf18fe4.png)

### Viewing a ticket's details

![](https://user-images.githubusercontent.com/12554095/62276703-7bfe4200-b3f9-11e9-8146-ae0d4e7aae72.png)

### Viewing an incident's tree

![](https://user-images.githubusercontent.com/12554095/62276704-7bfe4200-b3f9-11e9-8ddc-d445c289461b.png)
