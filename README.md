# webhook-translator

[![Build Status](https://travis-ci.org/rtlong/webhook-translator.png?branch=master)](https://travis-ci.org/rtlong/webhook-translator)

```
    +--------------+  +--------+  +-----------+
    |              |  |        |  |           |
    | Semaphore CI |  | GitHub |  | Anything! |
    |              |  |        |  |           |
    +------+-------+  +-----+--+  +-----+-----+
           |                |           |
           +-----------+    |    +------+
                       |    |    |
                       v    v    v
                  *--------------------* HTTP POST
                  |                    |     |
                  | webhook-translator |     |
                  |                    |     v
                  *---------+----------* HTTP POST
                            |
                            |
              +-------------+-------------+
              |             |             |
              |             |             |
              v             |             v
   +---------------------+  |  +------------------------+
   |                     |  |  |                        |
   | Flowdock Team Inbox |  |  | Pushover Notification? |
   |                     |  |  |                        |
   +---------------------+  |  +------------------------+
                            |
             +--------------+----------------+
             |              |                |
             v              v                v
         +-------+      +--------+      +-----------+
         |  IRC? |      | Hubot? |      | Anything! |
         +-------+      +--------+      +-----------+
```

