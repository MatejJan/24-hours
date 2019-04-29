export Resources = {}

--# Activities

Resource
  index: 0
  id: 'sleep'
  hourCost: 3

Resource
  index: 1
  id: 'body'
  hourCost: 2
  consumption:
    sleep: 1

Resource
  index: 2
  id: 'mind'
  hourCost: 2
  consumption:
    sleep: 1

Resource
  index: 3
  id: 'work'
  hourCost: 2
  initiallyAvailable: false
  consumption:
    sleep: 1

--# Environment

Resource
  index: 4
  id: 'people'
  hourCost: 1

Resource
  index: 5
  id: 'emotions'
  hourCost: 1

Resource
  index: 6
  id: 'travel'
  hourCost: 3

Resource
  index: 7
  id: 'school'
  hourCost: 2

Resource
  index: 8
  id: 'computer'
  hourCost: 1

--# Sports

Resource
  index: 9
  id: 'exercise'
  hourCost: 2
  consumption:
    body: 1

Resource
  index: 10
  id: 'sport'
  hourCost: 1
  consumption:
    exercise: 1
    play: 1

Resource
  index: 11
  id: 'athlete'
  hourCost: 1
  consumption:
    sport: 1
    work: 1

--# Games

Resource
  index: 12
  id: 'play'
  hourCost: 1
  consumption:
    friends: 1
    mind: 1

Resource
  index: 13
  id: 'videoGames'
  name: 'video games'
  hourCost: 1
  consumption:
    computer: 1
    play: 1

Resource
  index: 14
  id: 'esports'
  hourCost: 1
  consumption:
    videoGames: 1
    work: 1

--# Relationships

Resource
  index: 15
  id: 'friends'
  hourCost: 1
  consumption:
    people: 1

Resource
  index: 16
  id: 'love'
  hourCost: 1
  consumption:
    friends: 1
    emotions: 1

Resource
  index: 17
  id: 'marriage'
  hourCost: 1
  initiallyAvailable: false
  consumption:
    love: 1
    work: 1

Resource
  index: 18
  id: 'kids'
  hourCost: 3
  initiallyAvailable: false
  consumption:
    love: 1
    people: 1

--# Travel

Resource
  index: 19
  id: 'astronaut'
  hourCost: 10
  consumption:
    travel: 1
    science: 5

Resource
  index: 20
  id: 'driver'
  hourCost: 1
  consumption:
    travel: 1
    practice: 1

--# Mind career

Resource
  index: 21
  id: 'theory'
  hourCost: 1
  consumption:
    mind: 1
    school: 1

Resource
  index: 22
  id: 'science'
  hourCost: 1
  consumption:
    theory: 1
    work: 1

Resource
  index: 23
  id: 'programing'
  hourCost: 1
  consumption:
    computer: 1
    work: 1

--# Body career

Resource
  index: 24
  id: 'practice'
  hourCost: 1
  consumption:
    school: 1
    body: 1

Resource
  index: 25
  id: 'service'
  hourCost: 1
  consumption:
    practice: 1
    work: 1

Resource
  index: 26
  id: 'doctor'
  hourCost: 1
  consumption:
    theory: 1
    service: 1

--# Work career

Resource
  index: 27
  id: 'business'
  hourCost: 1
  consumption:
    school: 1
    work: 1

Resource
  index: 28
  id: 'startup'
  hourCost: 1
  consumption:
    business: 1
    computer: 1

--# Emotion career

Resource
  index: 29
  id: 'art'
  hourCost: 1
  consumption:
    emotions: 1
    work: 1

Resource
  index: 30
  id: 'dance'
  hourCost: 1
  consumption:
    emotions: 1
    exercise: 1

Resource
  index: 31
  id: 'acting'
  hourCost: 1
  consumption:
    art: 1
    body: 1

Resource
  index: 32
  id: 'music'
  hourCost: 1
  consumption:
    emotions: 1
    play: 1

Resource
  index: 33
  id: 'band'
  hourCost: 1
  consumption:
    music: 1
    friends: 1

Resource
  index: 34
  id: 'graphicDesign'
  name: 'graphic design'
  hourCost: 1
  consumption:
    art: 1
    computer: 1

Resource
  index: 35
  id: 'therapy'
  hourCost: 1
  consumption:
    emotions: 1
    theory: 1

--# People career

Resource
  index: 36
  id: 'politics'
  hourCost: 1
  consumption:
    people: 1
    theory: 1

Resource
  index: 37
  id: 'socialMedia'
  name: 'social media'
  hourCost: 1
  consumption:
    people: 1
    computer: 1

Resource
  index: 38
  id: 'influencer'
  hourCost: 1
  consumption:
    socialMedia: 1
    work: 1
