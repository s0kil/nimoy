import ../src/nimoy/tasks, ../src/nimoy/executors

proc ciao(): TaskStatus =
  echo "ciao"
  taskFinished

proc hello(): TaskStatus =
  echo "hello"
  taskFinished

proc salut(): TaskStatus =
  echo "salut"
  taskFinished

proc main() =
  var executor = createSimpleExecutor(3)

  executor.submit(ciao)
  executor.submit(hello)
  executor.submit(salut)

  executor.shutdown()
  executor.awaitTermination()

when isMainModule: main()
