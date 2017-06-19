# RoR_belt

Ruby on Rails application using ActiveRecord and Bootstrap

### User Story

Register or login with feedback of validation issues

Post bright ideas and like other people's ideas

See the most liked ideas and a complete list of ideas

Click on a user's alias to see their information and post & like stats

### Technical Points of Interest

RESTFUL routing

Models for users, ideas, and likes use one-to-many and many-to-many relationships

Model dependencies are established for destroy operations such that, for example, an idea's likes are deleted when the idea is deleted
