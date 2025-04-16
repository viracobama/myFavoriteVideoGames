Original App Design Project - README 
===

# myFavoriteVideoGame

## Table of Contents

1. [Overview](#Overview)
2. [Product Spec](#Product-Spec)
3. [Wireframes](#Wireframes)
4. [Schema](#Schema)

## Overview

### Description



### The myfavoritevideogames app allows users to view to seach video games via IGDB search endpoint. User's will be able to search up games, view game details, add games to wishlist/played lists, add/edit reviews for played games, and sort reviewed games.


- **Category:** Social/News
- **Mobile:** This application is designed to be used on mobile.  
- **Story:** Creates an environment where users create keep track of the past video games they have played and to keep an eye out for future ones to play.
- **Market:** Any user interested in keeping a log of their video game activity.
- **Habit:** Users will use this app to keep of track of future games they would like to play and games they have played.
- **Scope:** V1 would allow users to look up video games.  V2 would incorporate a review function and save wishlists/played lists V3 would wllow users to eventually sort their lists.

## Product Spec

### 1. User Stories - Inspirational

**Required Must-have Stories**

* My inspiration of this app was the use of websites like mydramalist and myanimelist. I've grown up watching shows and have struggled to keep track of all of the ones I've watched. Knowing that are online applications with this function, I'd figured I could make a videogame equivalent with a similar naming scheme - hence myvideogameslist.


### 2. Screen Archetypes

- [x] Search Screen
* This will be the first view. This will include a search bar at the top of the screen allowing users to look up video games. 
* User's can return to the table list view from the details page view via the navigation bar.
Wishlist Screen
* This is the wishlist screen. This screen is to display a list of games the user's have added from the game details screen.
Played Screen
* This is the played screen. This screen displays the list of the games the user's marked as played. 
Reviewed Screen
*  This is the list of games the user has left a reviewed on.

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Tab 1 - Search Games Tab
* Tab 2 - Wishlist Tab
* Tab 3 - Played Tab
* Tab 4 - Reviewed Tab

**Flow Navigation** (Screen to Screen)

- [x] Search Screen
* Game Details Screen
- [x] Wishlist Screen
* Games Details Screen

## Wireframes


Original Concept
<img src="https://i.imgur.com/KYZX09b.jpeg" width=600>

### [BONUS] Digital Wireframes & Mockups
Final Wireframe
<img src="https://github.com/viracobama/myFavoriteVideoGames/blob/main/images/MyFavoriteVideoGames%20Wireframe.jpg" width=600>

### [BONUS] Interactive Prototype

## Schema 

Look at wireframe above.

### Models

[Add table of models]

### Video Demonstration Link
[https://www.loom.com/share/d6c31191833646b5b01158af7141d2f6](https://www.loom.com/share/08188dfe104a4e09b7e183ba909f906d?sid=b1cb7a4b-99bd-4d7b-adaa-c9f4f4f7f9ee)

### Networking

- [Add list of network requests by screen ]
- <img src="https://github.com/viracobama/myFavoriteVideoGames/blob/main/images/network_request_1.png" width:600>
- <img src="https://github.com/viracobama/myFavoriteVideoGames/blob/main/images/network_request_2.png" width:600>
- [Create basic snippets for each Parse network request]
- [OPTIONAL: List endpoints if using existing API such as Yelp]
- endpoint: https://igdb-proxy-cc7025ef17a0.herokuapp.com/search is a proxied verion of https://api.igdb.com/v4/search which is hosted heroku.com
