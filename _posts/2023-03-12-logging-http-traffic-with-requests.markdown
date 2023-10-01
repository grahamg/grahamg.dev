---
layout: post
title:  "Logging HTTP Traffic in Python with Requests"
date:   2023-12-03
categories: python programming
---
There are several ways a programmer can log HTTP traffic for the purposes of debugging a larger script.

Frequently, my initial move is to import `pudb` to the Python file I'm debugging, and call `pudb.set_trace()` just after
the desired request or response in question is modified. Observing the desired HTTP request or response data simply becomes
a question of dumping the content of object such as `request.response.__dict__` to standard output.

But, what if this is a codebase that your unfamiliar with where their are many possible locations to insert breakpoints?
How can the debugging process be accelerated?

For simplicity's sake a contrived example script to debug needs to make some kind of HTTP request.

```
$ curl https://jsonplaceholder.typicode.com/todos/1
{
  "userId": 1,
  "id": 1,
  "title": "delectus aut autem",
  "completed": false
}
```

Ok, simple enough. That would make the debugging test subject to be the simple script.

```
import requests

request.get("https://jsonplaceholder.typicode.com/todos/1")
```

To caputure the requests and response objects, a class that inherits `requests.Session` can be used to host
the following functionality. Within example.py, `RecordingSession` would then be used instead of the requests library directly.

```
class RecordingSession(requests.Session):
    def __init__(self):
        super().__init__()
        self.record = []

    def request(self, method, url, **kwargs):
        response = super().request(method, url, **kwargs)
        self.record.append("    REQUEST: %s" % response.request.__dict__)
        self.record.append("    RESPONSE: %s" % response.__dict__)
        log = open("out.txt", "w")
        log.write(str(self.record))
        log.close()
        return response
```

In order for example.py to call this logging class, `request` is replaced with the instantionated `RecordingSession()` instance to become the following.

```
from requests_recorder import RecordingSession

session = RecordingSession()
response = session.get("https://jsonplaceholder.typicode.com/todos/1")

```

Now, when `python example.py` is executed, `log.txt` contains the logged request and response objects.

```
% cat log.txt 
["    REQUEST: {'method': 'GET', 'url': 'https://jsonplaceholder.typicode.com/todos/1', 'headers': {'User-Agent': 'python-requests/2.28.2', 'Accept-Encoding': 'gzip, deflate', 'Accept': '*/*', 'Connection': 'keep-alive'}, '_cookies': <RequestsCookieJar[]>, 'body': None, 'hooks': {'response': []}, '_body_position': None}", '    RESPONSE: {\'_content\': b\'{\\n  "userId": 1,\\n  "id": 1,\\n  "title": "delectus aut autem",\\n  "completed": false\\n}\', \'_content_consumed\': True, \'_next\': None, \'status_code\': 200, \'headers\': {\'Date\': \'Mon, 23 Jan 2023 02:54:18 GMT\', \'Content-Type\': \'application/json; charset=utf-8\', \'Transfer-Encoding\': \'chunked\', \'Connection\': \'keep-alive\', \'X-Powered-By\': \'Express\', \'X-Ratelimit-Limit\': \'1000\', \'X-Ratelimit-Remaining\': \'999\', \'X-Ratelimit-Reset\': \'1670272279\', \'Vary\': \'Origin, Accept-Encoding\', \'Access-Control-Allow-Credentials\': \'true\', \'Cache-Control\': \'max-age=43200\', \'Pragma\': \'no-cache\', \'Expires\': \'-1\', \'X-Content-Type-Options\': \'nosniff\', \'Etag\': \'W/"53-hfEnumeNh6YirfjyjaujcOPPT+s"\', \'Via\': \'1.1 vegur\', \'CF-Cache-Status\': \'HIT\', \'Age\': \'22026\', \'Server-Timing\': \'cf-q-config;dur=6.0000020312145e-06\', \'Report-To\': \'{"endpoints":[{"url":"https:\\\\/\\\\/a.nel.cloudflare.com\\\\/report\\\\/v3?s=ccL0WH9Tcm4zbEoi8AtDK8Dn%2FL7Xc8U%2BQ7R0Xzr8cmEUyEGCfhm26ktV3sW7W3jhr0FRj4CR0c%2Bf1CSstgctJ8kWDviGo2yT7wpXPP5q99dWkbEX5xL85%2BfHRxaPJIMZnUw39WnEsCQWHCFSRBlM9kePm0%2Bidroq4Mtu"}],"group":"cf-nel","max_age":604800}\', \'NEL\': \'{"success_fraction":0,"report_to":"cf-nel","max_age":604800}\', \'Server\': \'cloudflare\', \'CF-RAY\': \'78dd3e732b602d91-ORD\', \'Content-Encoding\': \'gzip\', \'alt-svc\': \'h3=":443"; ma=86400, h3-29=":443"; ma=86400\'}, \'raw\': <urllib3.response.HTTPResponse object at 0x7fd3381bf5d0>, \'url\': \'https://jsonplaceholder.typicode.com/todos/1\', \'encoding\': \'utf-8\', \'history\': [], \'reason\': \'OK\', \'cookies\': <RequestsCookieJar[]>, \'elapsed\': datetime.timedelta(microseconds=101794), \'request\': <PreparedRequest [GET]>, \'connection\': <requests.adapters.HTTPAdapter object at 0x7fd3480d0450>}']%
```

With this functionality, by replacing the request object with the instantiated log class, we can build out logging functionality rapidly and get a better idea what's going on.
