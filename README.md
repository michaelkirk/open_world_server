Open World Server
==================

A dumb service for storing and retrieiving spatially aware content. 

Are you building a map of photos / restaurants / &lt;stuff&gt; ?  Maybe this
service can get you jump started. 

Assuming you can serialize your &lt;stuff&gt; to a string representation, this
service will take care of storing it and retrieving it by location -
allowing you to (e.g.) get all the &lt;stuff&gt; on the current map pane.

API
===

record a point
--------------
Create a new point along with any payload(s).

In this example the payload data happens to be a string of JSON. But it
could be anything representable as a string (e.g. base64 encoded binary
blobs). The intent is that the payload data is opaque to the server, and
serialized / deserialized by the client. 


request

    POST /points 
      { point: { 
          latitude: "12.3",
          longitude: "45.6",
          payloads: [{ 
            payload_type: "photo", 
            data: '{
              "url": "s3://mybucket/photo.jpg",
              "author_name": "ed"
            }'
          }]
        }
      }

response
  
    201 CREATED
    Location: /points/666
      { point: { 
          id: 666,
          latitude: "12.3",
          longitude: "45.6",
          payloads: [{ 
            id: 98,
            point_id: 666,
            payload_type: "photo", 
            data: '{
              "url": "s3://mybucket/photo.jpg",
              "author_name": "ed"
            }'
          }]
        }
      }

query
--------
Query for all points (and their payloads) within a bounding box.

In line with postgis, the bounding box is defined by it's 4 sides.

E.g. The intersection of Cedar & Riverside in Minneapolis has latitude:
44.97020 and longitude: -93.24723. To set this as the soutwest
corner of our bounding box, we pass the GET parameter thus:

    west=-93.24689&south=44.97005

We'll have to similarly define the north and east edges to complete
our query.


request

    GET /points?west=0&south=10.0&east=20.0&north=30.0

response

    [
      { point: { 
          id: 1,
          latitude: "26.5",
          longitude: "15.2",
          deleted: false,
          payloads: [{ 
              id: 1,
              point_id: 1,
              payload_type: "photo", 
              flag_count: 0,
              data: '{
                url: "s3://mybucket/photo.jpg",
                width: 500,
                height: 200 
              }'
            },
            { 
              id: 2,
              point_id: 1,
              payload_type: "comment", 
              flag_count: 2,
              data: '{
                text: "This photo is awesome" 
              }'
            }
          ]
        }
      },  
      { point: {
          id: 4,
          latitude: "15.1",
          longitude: "8.2"
          payloads: [
            { 
              id: 6,
              point_id: 4,
              payload_type: "photo", 
              flag_count: 0,
              data: '{
                url: "s3://mybucket/photo3.jpg",
                width: 500,
                height: 200 
              }'
            }
          ]
        }
      }
    ]


fetch
-----
Get a specific point by id.

request

    GET /points/1

response

      { point: {
          id: 1,
          latitude: "50",
          longitude: "275",
          payloads: [
            { 
              id: 1,
              point_id: 1,
              payload_type: "photo", 
              flag_count: 0,
              data: '{
                url: "s3://mybucket/photo.jpg",
                width: 500,
                height: 200 
              }'
            },
            { 
              id: 2,
              point_id: 1,
              payload_type: "comment", 
              flag_count: 0,
              data: '{
                text: "This photo is awesome" 
              }'
            }
          ]
        }
      }

Payloads
========

attach
------
Attach a payload to a point.

request

    POST /points/1/payloads

      {
        payload_type: "comment",
        data: "Your photos suck."
      }

response

    201 CREATED
    Location: /points/1/payloads/4
    { payload: {
        id: 4,
        point_id: 1,
        payload_type: "comment",
        data: "Your photos suck."
      }
    }


fetch
-----
Get a payload

request

    GET /points/1/payloads/4

response

      { payload: {
          id: 4,
          point_id: 1,
          payload_type: "photo",
          data: '{ 
            "url": "s3://mybucket/photo.jpg",
            "width": 500,
            "height": 200 
          }'
        }
      }



Development
===========

Always lot's to do! See here for the priority queue:
https://www.pivotaltracker.com/projects/720649#

