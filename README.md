# letsmuk
##Inspiration
It's lunchtime. You quickly grab a bite to eat and sit by yourself while you munch it down alone. While food clearly has the power to bring people together, the pandemic has separated us from friends and family with whom we love to eat together with

Muk means Eat in in Korean 🍽️ Eating is such an essential and frequent part of our daily lives, but eating alone has become the "norm" nowadays. With the addition of the lockdown and working from home, it is even harder to be social over food. Even worse, some young people are too busy to eat at home at all.

This brings significant health drawbacks, including chances to lead to obesity, higher risk factors for prediabetes, risk of having metabolic syndrome, high blood pressure, and higher cholesterol. This is because loneliness and lack of social support lead to physical wear and anxiety 🤒

We rely on relationships for emotional support and stress management ✨🧑‍🤝‍🧑 This is why we became inspired to make eating social again. With LetsMuk, we bring available the interactions of catching up with friends or meeting someone new, so that you won't spend your next meal alone anymore.

This project targets the health challenge because of the profound problems related to loneliness and mental health. With young people working from home, it brings back the social-ness of lunching with coworkers. Among seniors, it levitates them from isolation during a lonely meal. For friends over a distance, it provides them a chance to re-connect and catch up. 💬🥂

##How we built it
We chose Flutter as our mobile framework to support iOS and Android and leveraged its tight integrations with Google Firebase. We used Firebase's real-time database as our user store and built a Ruby on Rails API with PostgreSQL to serve as a broker and source of truth. Our API takes care of two workflows: storing and querying schedules, and communication with Agora's video chat API to query the active channels and the users within them.

Here is the video demo of when one joins a room YouTube Demo on entering a room

##Challenges we ran into
This is the first time any of us has worked with Flutter, and none of us had in-depth mobile development experience. We went through initial hurdles simply setting up the mobile environment as well as getting the Flutter app running. Dart is a new language to us, so we took the time to learn it from scratch and met challenges with calling async functions, building the UI scaffold, and connecting our backend APIs to it. We also ran into issues calling the Agora API for our video-chat, as our users' uid did not cohere with the API's int size restriction.

##Accomplishments that we're proud of
- It works!!
- Building out a polished UI
- Seeing your friends who are eating right now
- Ease of starting a meal and joining a room
- "Mukking" together with our team!

##What we learned
- Mobile development with Flutter and Dart
- User authentication with Firebase
- Video call application with Agora
- API development with Ruby on Rails
- Firebase and Postgres databases (NoSQL and SQL)

##What's next for LetsMuk
Schedule integration - put in when you eat every day
Notifications - reminders to your friends and followers when you're eating.
LetsMuk for teams/enterprise - eat with coworkers or students
Better social integration - FB, twitter, "followers"

- [On Devpost](https://devpost.com/software/lunchroom)

