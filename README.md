Open World Server
==================
Geospatial service for storing and retrieving arbitrary payloads.

Hosted at open-world.herokuapp.com

API
===

store
-----
Stash a JSON payload along with it's location.


request

    POST /points 
      { 
        latitude: "12.3",
        longitude: "45.6",
        payloads: [{ 
          payload_type: "photo", 
          data: {
            "url": "s3://mybucket/photo.jpg",
            "author_name": "ed"
          }
        }]
      }

response
  
    201 CREATED
    Location: http://www.example.com/
      { 
        id: 123,
        latitude: "12.3",
        longitude: "45.6",
        payloads: [{ 
          payload_type: "photo", 
          data: {
            "url": "s3://mybucket/photo.jpg",
            "author_name": "ed"
          }
        }]
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
        latitude: "50",
        longitude: "275",
        deleted: false,
        payloads: [
          { 
            point_id: 1,
            payload_id: 1,
            payload_type: "photo", 
            flag_count: 0,
            data: {
              url: "s3://mybucket/photo.jpg",
              width: 500,
              height: 200 
            }
          },
          { 
            point_id: 1,
            payload_id: 2,
            payload_type: "comment", 
            flag_count: 2,
            data: {
              text: "This photo is awesome" 
            }
          }
        ]
      },
      { 
        id: 4,
        latitude: "75",
        longitude: "250"
        payloads: [
          { 
            point_id: 2,
            payload_id: 6,
            payload_type: "photo", 
            flag_count: 0,
            data: {
              url: "s3://mybucket/photo3.jpg",
              width: 500,
              height: 200 
            }
          }
        ]
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
        latitude: "50",
        longitude: "275",
        payloads: [
          { 
            point_id: 1,
            payload_id: 1,
            payload_type: "photo", 
            flag_count: 0,
            data: {
              url: "s3://mybucket/photo.jpg",
              width: 500,
              height: 200 
            }
          },
          { 
            point_id: 1,
            payload_id: 2,
            payload_type: "comment", 
            flag_count: 0,
            data: {
              text: "This photo is awesome" 
            }
          }
        ]
      },

Payloads
========

attach
------
Attach a payload to a point.

request

    POST /points/1/payloads

      {
        payload_type: "comment",
        data: { 
          "text": "Your photos suck."
        }
      }

response

    201 CREATED

      /points/1/payloads/4


    FLAG /points/1/payloads/4

    FLAG /points/1




fetch
-----
Get a payload

request

    GET /points/1/payloads/4

response

      {
        id: 4,
        point_id: 1,
        payload_type: "photo",
        data: { 
          "url": "s3://mybucket/photo.jpg",
          "width": 500,
          "height": 200 
        }
      }



Development
===========

Always lot's to do! See here for the priority queue:
https://www.pivotaltracker.com/projects/720649#

