# README

## Requirements
Ruby 2+, bundler

## How to run
```
git clone git@github.com:omnikron/chamolix.git && cd chamolix
bundle install
rails s
```

API will be running at http://localhost:3000.

## Search
To search/sort/filter results use the following query params, which can be used
alone (except for `sort_direction`) or in conjunction with each other:

```
name_search       # text, case-insensitive
difficulty_filter # 1-5
sort_key          # name, id, ski_difficulty
sort_direction    # asc(default) or desc
```

e.g.
http://localhost:3000/lines?name_search=couloir&difficulty_filter=3&sort_key=name&sort_direction=desc


## View
Any line with geo coordinates can be viewed at `/lines/:id` This returns html
that displays the line in a canvas element.

e.g.  http://localhost:3000/lines/9514
