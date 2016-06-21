# KenLee

![KenLee](https://coubsecure-a.akamaihd.net/get/b8/p/coub/simple/cw_timeline_pic/4ab1abe9170/4a7bc3ab94f86a511f38a/med_1412069622_image.jpg)

## What is KenLee?

**KenLee** is a Ruby Gem that aims to generate *random*/*fake* data by using various web service APIs.

## How to use KenLee?

Currently, only one submodule for KenLee exists.

*KenLee* submodules:
* WikiLee.

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
