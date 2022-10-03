# API User Authentication

A ruby on rails api implementation of simple User Authentication for Lendesk Coding Challenge.


## Versions
* Ruby 2.7.4
* Rails 6.1.7

## Pre-Requisite

* Redis

## Approach

Haven't experienced using Redis as the primary database, so I had to research on how to do it. I have 2 options:
* redis-object
* ohm

I decided to go with `ohm` because of different drop-in modules that I can use like the `ohm-validations` and `ohm-contrib`, which makes the class `User` similar to an `ActiveRecord::Model`

Made my own implementation of `has_secured_password` to use on the class `User` which uses `bcrypt` for Encoding and Decoding of password.

Added `jwt` to handle API authentication if needed, can be removed by commenting the
```
before_action :authorize_request, except: :create
```
in `users_controller.rb`

