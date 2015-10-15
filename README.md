## Ross Kinsella
## Submit ID : 0105a7b6c410f4f3ae2d2acab136fa2744b7b80012e46ff3214ebb93579a1abc

### Dependancies
1. [Socket] (http://ruby-doc.org/stdlib-1.9.3/libdoc/socket/rdoc/Socket.html)
  - Part of standard library.
  - Used for creating the server, handling requests and the socket itself.
2. [Thread] (http://ruby-doc.org/core-2.2.3/Thread.html)
  - Part of standard library.
  - Used for creating threads.
3. [ThreadPool] (http://www.burgestrand.se/code/ruby-thread-pool/)
  - Snippet I found while googling 'ruby simple thread pool'. It's pretty straight forward, the only interesting thing is ```Queue#pop``` is blocking, meaning it will wait until something is in the queue before proceeding. Queue, part of ruby standard libray is built with multi threading in mind.
  - Used for creating a simple thread pool which pools a queue for jobs to do.