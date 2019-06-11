# Build A Buddy

## Time Spent:

I started on Friday evening (6/7) and worked on it off and on over the weekend as time allowed.
I probably hit the 4-hour mark on Saturday in the data migration step but kept going as I was having too much fun. :smile:.

I got as far as the "Other People Also Bought" item recommendation engine (which you will see once you clone the project, run the data import and start the local server)

## Steps to run

In a terminal:

```
$ git clone https://github.com/jhoutz/build_a_buddy.git
$ cd build_a_buddy
$ rvm install ruby-2.6.0
$ gem install bundler
$ bundle install
$ rails db:create db:migrate import:csv_data
$ rails s
```

## The Fun Stuff

TL;DR (For the visual people) - Check out [the data structure PDF](https://github.com/jhoutz/build_a_buddy/blob/master/erd.pdf).

I went with a data structure that started with Daniel Clark's easily scalable schema described in his post: [Rails: Has One Through Polymorphic Relation](https://6ftdan.com/allyourdev/2016/03/22/rails-has-one-through-polymorphic-relation/).

In this structure, all products are an `Item`. So in this particular case, `StuffedAnimal` and `Accessory` are both an `Item`. This allows the app to scale to offer any additional items in the future very easily (say, if Build A Buddy decides to start selling Cabbage Patch dolls...or whatever else the kids are into these days).

Also, every `Item` has multiple `ItemVariation`'s (size, quantity, color, etc). And it's the `ItemVariation` that is used for `PurchaseOrder`'s.

As for coupling `StuffedAnimal` with `Accessory`, the `ItemVariation` model has a self-referential relationship using the `ItemVarPairing`. This allows for an instance of `ItemVariation` to pair with any other instance of `ItemVariation`. I did this in case there was ever a need to pair, for instance, one `Accessory` to another `Accessory` (as perhaps a sub-accessory?).

## RSpec:

Testing for this was pretty light since the bulk of the work was in the data structure formation and data ingestion from a non-standard CSV data source.

RSpec tests can be run using:

```
$ rspec
```

## Other Stuff:

Rubocop is used for proper code style adherence. To run Rubocop:

```
$ rubocop
$ rubocop -a # Automatically fixes code style issues
```
