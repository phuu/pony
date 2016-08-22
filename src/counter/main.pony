use "collections"

// Playing around with concurrent execution with actors
// Discovered that passing back to Main to show would mean
// the behaviors were serialised. Creating a Show instance
// for each counter allows the get->show step to finish
// without coordination.

actor Main
  new create(env: Env) =>
    for n in Range[U32](0,100) do
      let show = Show(env)
      for m in Range[U32](0,100) do
        let counter = Counter(n + m)
        for x in Range[U32](0,1000) do
          counter.increment()
        end
        counter.get(show)
      end
    end

actor Show
  var _env: Env
  new create(env: Env) =>
    _env = env

  be show(id: U32, result: U32) =>
    _env.out.print(id.string() + " => " + result.string())

actor Counter
  var _id: U32
  var _count: U32
  new create(id: U32) =>
    _id = id
    _count = 0

  be increment() =>
    _count = _count + 1

  be get(show: Show) =>
    show.show(_id, _count)
