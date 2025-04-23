const mockHistoricalEventJson = '''
  {
    "id": 1,
    "title": "Falcon 1 Makes History",
    "event_date_utc": "2008-09-28T23:15:00Z",
    "event_date_unix": 1222643700,
    "flight_number": 4,
    "details": "Falcon 1 becomes the first privately developed liquid fuel rocket to reach Earth orbit.",
    "links": {
        "reddit": null,
        "article": "http://www.spacex.com/news/2013/02/11/flight-4-launch-update-0",
        "wikipedia": "https://en.wikipedia.org/wiki/Falcon_1"
    }
  }
''';

const mockHistoricalEventsJson = '''
  [
    {
        "id": 1,
        "title": "Falcon 1 Makes History",
        "event_date_utc": "2008-09-28T23:15:00Z",
        "event_date_unix": 1222643700,
        "flight_number": 4,
        "details": "Falcon 1 becomes the first privately developed liquid fuel rocket to reach Earth orbit.",
        "links": {
            "reddit": null,
            "article": "http://www.spacex.com/news/2013/02/11/flight-4-launch-update-0",
            "wikipedia": "https://en.wikipedia.org/wiki/Falcon_1"
        }
    },
    {
        "id": 2,
        "title": "SpaceX Wins \$1.6B CRS Contract",
        "event_date_utc": "2008-12-23T01:00:00Z",
        "event_date_unix": 1229994000,
        "flight_number": null,
        "details": "NASA awards SpaceX \$1.6B Commercial Resupply Services (CRS) contract.",
        "links": {
            "reddit": null,
            "article": "https://www.nasaspaceflight.com/2008/12/spacex-and-orbital-win-huge-crs-contract-from-nasa/",
            "wikipedia": "https://en.wikipedia.org/wiki/Commercial_Resupply_Services"
        }
    },
    {
        "id": 3,
        "title": "Falcon 1 Flight 5 Makes History",
        "event_date_utc": "2009-07-13T03:35:00Z",
        "event_date_unix": 1247456100,
        "flight_number": 5,
        "details": "Falcon 1 Flight 5 makes history, becoming the first privately developed liquid fuel rocket to deliver a commercial satellite to Earth orbit.",
        "links": {
            "reddit": null,
            "article": "http://www.spacex.com/news/2013/02/12/falcon-1-flight-5",
            "wikipedia": "https://en.wikipedia.org/wiki/Falcon_1"
        }
    },
    {
        "id": 4,
        "title": "Falcon 9 First Flight",
        "event_date_utc": "2010-06-04T18:45:00Z",
        "event_date_unix": 1275677100,
        "flight_number": 6,
        "details": "Met 100% of mission objectives on the first flight!",
        "links": {
            "reddit": null,
            "article": "http://www.bbc.com/news/10209704",
            "wikipedia": "https://en.wikipedia.org/wiki/Dragon_Spacecraft_Qualification_Unit"
        }
    },
    {
        "id": 5,
        "title": "Dragon Returns From Earth Orbit",
        "event_date_utc": "2010-12-08T15:43:00Z",
        "event_date_unix": 1291822980,
        "flight_number": 7,
        "details": "On December 8, 2010, Dragon became the first privately developed spacecraft in history to re-enter from low-Earth orbit.",
        "links": {
            "reddit": null,
            "article": "http://www.cnn.com/2010/US/12/08/space.flight/index.html",
            "wikipedia": "https://en.wikipedia.org/wiki/SpaceX_COTS_Demo_Flight_1"
        }
    },
    {
        "id": 6,
        "title": "First Dragon Visit to Space Station",
        "event_date_utc": "2012-10-08T00:35:00Z",
        "event_date_unix": 1349656500,
        "flight_number": 9,
        "details": "Dragon becomes the first private spacecraft in history to visit the space station.",
        "links": {
            "reddit": null,
            "article": "http://thespacereview.com/article/2168/1",
            "wikipedia": "https://en.wikipedia.org/wiki/SpaceX_CRS-1"
        }
    }
  ]
''';
