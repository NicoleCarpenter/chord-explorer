#[Chord Explorer](#)

> Bring music to the world, one chord at a time.

Chord Explorer is an innovative tool that helps individuals learn how to play guitar and intuitively expand their repitoire. The app allows users to increase their current music knowledge by introducing them to songs that match their current skill level and chord toolbag.

The user is introduced to the website by an option to search using either comma separated values or clickable chord images. Once the user has amassed the chords they want included in the search, the app will generate a list of songs which predominately use those chords. The songs will link to a third party website which will provide the full tab version of the song.

Preferably users should be able to save chords in their repertoire, see a list of their most recent searches, and the app should be able to suggest, based on usage, current repertoire and frequency of appearance, a new chord that may be suited for the user to learn as the next logical chord.

##The Team:

* Andy Dierker
* Dennis Tam
* Erik Germani
* Nicholas Christiny
* Nicole Carpenter

##Technologies

* [Ruby on Rails](http://rubyonrails.org/) - Open source framework upon which the app is based (version 4.2.4)
* [Ruby](http://rubyonrails.org/) - Programming Language primarily used in the app (version 2.2.1)
* [Heroku](www.heroku.com) - Host platform for the app
* [Guitar Party API](http://www.guitarparty.com/developers/) - API used for song and chord data
* [Anemone](https://github.com/chriskite/anemone) - Web crawler framework used for collecting song data from third party sites
* [Bootstrap](http://getbootstrap.com/) - HTML, CSS, and JS framework for developing responsive, mobile first projects on the web
* [Chords.io](https://github.com/guitarparty/chords.io) -Chords.io is a small jQuery plugin to display guitar chords using Raphaël SVG library.

##User Stories

###MVP

####User Registration and Login
* As a non-logged in user, I want to be able to register for a new account and be redirected to the home page.
* As a non-logged in user, I want to be able to register for a new account and be redirected to the home page.
* As a non-logged in user, I want to be able to log in to my account and be redirected to the home page.

####User Profile
* As a logged in user, when I visit the homepage I will see a "My Profile" link at the top of the main side bar.
* As a logged in user, I want my profile page to include chords that I have favorited.
* As a logged in user, I want my profile to list songs that I have saved.
* As a logged in user, I want my profile to include a section with recent chords I have searched for.
* As a logged in user, I want my profile to include a section with recent songs that I have clicked.

####Developer
* As a developer, I want to be able to compile a list of songs and the chords they contain.
*As a developer, I want to be able to select from compiled songs which version of the song is most reputable.
* As a developer, I want to present a styled website.

####Main Search Functionality
* As a user, I should be able to enter multiple chords into a search bar, comma separated and click enter to have them appear in the 'selected chord' area at the top of the page.
* As a user, I want to be able to click on a chord family (i.e.: major) and have a list of names of clickable chords appear.
* As a user, I want to be able to click on chords in expanded chord family and have those chord selections appear in the 'selected chord' area on the top of the page.
* As a user, I want to be able to click a button ("FIND SONGS") and have results appear.

####Display Results
* As a user, after I search, I want to see a list of songs that utilize the chords that I searched for.
* As a user, after I search, I want to see what chords I just searched for.
* As a user, after I search, I should see a some chord-cards from the returned songs, and click an "expand" link to see the full list of chord-cards.

####Additional Features
* As a user, I want to be able to view the chord library, a collection of chord cards separated by chord family.
* As a user, I want the option to save a song to my profile when I know it.
