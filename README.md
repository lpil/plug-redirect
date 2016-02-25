PlugRedirect
============

A plug for performing redirects based upon request path.


## Usage

Add PlugRedirect to your Mix dependencies

```elixir
# mix.exs
def deps do
  [
    {:plug_redirect "~> 0.0"},
  ]
end
```

Fetch it:

```
mix deps.get
```

Create a new module and specify your redirects like so:

```elixir
defmodule MyApp.RedirectPlug do
  use Plug.Redirect

  # Argument #1 is the 30x status code to use
  # Argument #2 is the path to redirect from
  # Argument #3 is the path to redirect to

  redirect 301, "/ada",   "/lovelace"
  redirect 302, "/grace", "/hopper"
  redirect 303, "/adele", "/goldberg"
  redirect 307, "/sandi", "/metz"
end
```

This compiles into a plug that you can insert into your application's
plug middleware stack.

In Phoenix, insert the plug in your web application Endpoint.

```elixir
defmodule MyApp.Endpoint do
  use Phoenix.Endpoint, otp_app: :my_app

  plug Plug.RequestId
  plug Plug.Logger

  # After the logger is a good spot to insert
  plug MyApp.RedirectPlug

  plug Plug.MethodOverride
  plug Plug.Head

  plug MyApp.Router
end
```


# LICENCE

```
PlugRedirect
Copyright © 2016 - Present Louis Pilfold - MIT Licence

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the "Software"),
to deal in the Software without restriction, including without limitation
the rights to use, copy, modify, merge, publish, distribute, sublicense,
and/or sell copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included
in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE
OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
```
