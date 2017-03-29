#  <img align=right src="img/nimoy.png" alt="Nimoy Icon" /> Nimoy

An experimental minimal actor library for Nim.

```nim
  # foo receives at least 10 msgs then becomes "done"
  let foo = createActor[int] do (self: ActorRef[int]):
    var count = 0
    proc done(self: ActorRef[int], e: Envelope[int]) =
      echo "DISCARD."

    proc receive(self: ActorRef[int], e: Envelope[int]) =
      echo "foo has received ", e.message
      e.sender.send(e.message + 1)
      count += 1
      if count >= 10:
        self.become(done)

    self.become(ActorBehavior[int](receive))

  # bar responds to foo
  let bar = createActor do (self: ActorRef[int]):
    proc receive(self: ActorRef[int], e: Envelope[int]) =
      echo "bar has received ", e.message
      e.sender.send(e.message + 1)

    self.become(receive)


  var executor = createExecutor()

  executor.submit(foo.toTask())
  executor.submit(bar.toTask())
  
  # kick it off 
  bar.send(Envelope[int](message: 1, sender: foo))
  
  # start the execution
  executor.start()
```
