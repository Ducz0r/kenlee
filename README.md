# KenLee

![KenLee](https://coubsecure-a.akamaihd.net/get/b8/p/coub/simple/cw_timeline_pic/4ab1abe9170/4a7bc3ab94f86a511f38a/med_1412069622_image.jpg)

## What is KenLee?

**KenLee** is a Ruby Gem that aims to generate *random* data by using various web service APIs. This is a different strategy than what most random/fake data generators (e.g. [Faker](https://github.com/stympy/faker)) employ.

## How to use KenLee?

Firstly, you need to include the Gem in your application. Since the Gem is not yet available on [RubyGems](https://rubygems.org/), the easiest option is to do the following:

1. Clone this Git repository somewhere onto your drive.
2. Navigate to the Gem folder and execute:
```ruby
gem build kenlee.gemspec
```
3. This will build you a `kenlee-x.y.z.gem` Gem file.
4. You can now install the Gem:
```ruby
gem install ./kenlee-x.y.z.gem
```
5. Now, you can require the Gem from your application!
```ruby
require "kenlee"
```

## KenLee submodules

Currently, only one submodule for KenLee exists.

| **Submodule** | **Description**                      |
|---------------|--------------------------------------|
| WikiLee       | Fetches random Wikipedia pages data. |

### WikiLee

First, you need to initialize a `WikiLee` object with a specific Wikipedia language (it defaults to `en`):
```ruby
wl = WikiLee.initialize(:en)
```
To query random extract/s from Wikipedia pages:
```ruby
text = wl.extract
texts = wl.extracts(15)
```
To query random links from Wikipedia pages:
```ruby
url = wl.link
urls = wl.links(8)
```
