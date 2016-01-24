## About

This pivotal gem is designed to work with v5 of Pivotal Tracker's API. There are no external dependencies,
so you'll never have to worry about conflicts.

## Usage

### To search for a story:
```ruby
Story.where(id: 123456789)
```

You can fetch many at one time:
```ruby
filters = {with_state: :accepted, with_story_type: :bug, limit: 10}
Story.where(filters)
```

Each of the story attributes that come back from Pivotal's API can be accessed via attr_readers so you can do things like:
```ruby
filters = {with_label: :urgent}
Story.where(filters).sort_by(&:accepted_at).last.name
```

Now that you have a story, you can add a label (each call to `add_label` will make a Post request):
```ruby
filters = {with_state: :accepted, with_story_type: :chore, limit: 10}
Story.where(filters).each {|s| s.add_label('whatever label name')}
```

[Here are the docs](http://www.pivotaltracker.com/help/api/rest/v5#Stories) for what search params can be used to find stories.
