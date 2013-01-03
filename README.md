Open World Server
==================
Geospatial service for storing and retrieving arbitrary payloads.

Hosted at open-world.herokuapp.com

API
===

store
-----
Stash a JSON payload along with it's location.

    POST /points 
      { 
        category: "photo", 
        payload: { 
          "url": "s3://mybucket/photo.jpg",
          "width": 500,
          "height": 200 
        },
        latitude: "123",
        longitude: "456"
      }

query
--------
Query for all points within a bounding box.


In line with postgis, the bounding box is defined by it's 4 sides.

E.g. The intersection of Cedar & Riverside in Minneapolis has latitude:
44.97020 and longitude: -93.24723. To set this as the soutwest
corner of our bounding box, we pass the GET parameter thus:

    west=-93.24689&south=44.97005

We'll have to similarly define the north and east corners to complete
our query.


request

    GET /points?west=0&south=1&east=2&north=3

response

    [
      { 
        id: 1,
        category: "photo", 
        payload: { 
          "url": "s3://mybucket/photo.jpg",
          "width": 500,
          "height": 200 
        },
        latitude: "50",
        longitude: "275"
      },
      { 
        id: 2,
        category: "photo", 
        payload: { 
          "url": "s3://mybucket/photo3.jpg",
          "width": 500,
          "height": 200 
        },
        latitude: "75",
        longitude: "250"
      }
    ]


fetch
-----
Get a specific point by id.

request

    GET /points/1

response

     { 
        id: 1,
        category: "photo", 
        payload: { 
          "url": "s3://mybucket/photo.jpg",
          "width": 500,
          "height": 200 
        },
        latitude: "123",
        longitude: "456"
      }


Development
===========

Always lot's to do! See here for the priority queue:
https://www.pivotaltracker.com/projects/720649#

