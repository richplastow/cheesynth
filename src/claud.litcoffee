Claud 0.0.0
===========




Define the `Claud` class
------------------------

    class Claud
      toString: -> '[object Claud]'




Define the constructor
----------------------

      constructor: (opt={}) ->
        @log = new Filog({ selector: opt.selectors.out, console:no }).log
        @in = document.querySelector opt.selectors.in
        @in.setAttribute 'contenteditable', 'true'
        @in.addEventListener 'keydown', @keydown

        @commands = []
        @pointer  = 0




Define public methods
---------------------

#### `add()`
Simulate typing a line of text in the CLI, and then hitting [return]. 

      add: (line) ->
        @pointer = (@commands.push @log line) - 1
        @ # allow chaining


#### `run()`
Simulate hitting [return] in the CLI. 

      run: ->
        try eval @commands[ @commands.length - 1] catch e
          @log e; console.log e


#### `keydown()`
React to [return], and the [up] and [down] arrow keys. 

      keydown: (evt) =>
        #@log evt.keyCode
        switch evt.keyCode
          when 13 # [return]
            @pointer = (@commands.push @log @in.textContent) - 1
            @in.innerHTML = ''
            @run()
            evt.preventDefault() # don't make a new line in `@in`
          when 38 # [up]
            @pointer = Math.max 0, @pointer - 1
            @in.innerHTML = @commands[@pointer]
            evt.preventDefault() # don't make a new line in `@in`
          when 40 # [down]
            @pointer = Math.min @commands.length - 1, @pointer + 1
            @in.innerHTML = @commands[@pointer]
            evt.preventDefault() # don't make a new line in `@in`




Export `Claud`
------------------

Allow Claud to be accessed from anywhere, eg using `cft = new Claud()`.  
@todo export for RequireJS etc

    window.Claud = Claud

