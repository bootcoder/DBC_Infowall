# [DBC Infowall](http://dbc-infowall.herokuapp.com)

## Deprecated Info
The API portion of this app has been deprecated. Find the decoupled API @ [dbc-infowall-api](https://github.com/bootcoder/dbc-infowall-api)

The Frontend React portion remains the live, consuming the new API. Eventually I plan to replace with [dbc-infowall-frontend](https://github.com/bootcoder/dbc-infowall-frontend) as a standalone React app.

When the frontend app is complete this app will be permanently deprecated.

### Will display various information regarding DBC student facing events.

  - Upcoming DBC Events
  - Special Events
  - News and Info

### Feature Request
- Mentors currently on-site (DONE)
- Events in space (DONE)
- Staff Currently on-site (DONE)
- Map
- Phase specific info (if we get multiple displays in the space...)
  - EX p1 learning objectives per day

### Spinning Up

- Clone the repo

```
$ git clone https://github.com/bootcoder/DBC_Infowall
```

- Install dependencies
```
$ bundle install
```

- Create a .env file in the root dir of the app
```
$ touch .env
```
You'll need the contents of .env, email Bootcoder

- Create migrate and seed the database
```
$ be rake db:create
$ be rake db:migrate
$ be rake db:seed
```

- Spool up the Rails server
```
$ rails s
```

### TV Display
Currently the Infowall is displayed on the foyer TV using a Mac Mini to render the page.
This documentation will be updated as the app is rolled out to additional TV's in the space.

If you encounter this display you may need to login to the Mac to refresh the page in chrome.

![heroku-error](app/assets/images/readme/heroku-error.png)

- Open Finder

- Click All under Shared

![all-shared](app/assets/images/readme/all-shared.png)

- Find and open DBC-TV

![dbc-tv](app/assets/images/readme/dbc-tv.png)

- Find and open DBC-TV

![share-screen](app/assets/images/readme/share-screen.png)

- Enter credentials to access the DBC-TV MacMini. (Recommend to save to your keychain)
  - Username: apprentice
  - Password: DBC Standard Image Password (ask Hunter / Patrick if you don't know)

- This will open a new window with the DBC-TV mirrored.
- Simply hover near the top to get the chrome menu to dropdown which will allow you to refresh the page.
