[![Build Status](https://travis-ci.org/joedursun/pivotal.png)](https://travis-ci.org/joedursun/pivotal)
[![Code Climate](https://codeclimate.com/github/joedursun/pivotal/badges/gpa.svg)](https://codeclimate.com/github/joedursun/pivotal)

## About
This pivotal gem is designed to work with v5 of Pivotal Tracker's API. There are no external dependencies,
so you'll never have to worry about conflicts.

To see all of the supported functionality of Pivotal API v5, [check out their docs here](http://www.pivotaltracker.com/help/api/rest/v5#top). At the moment, this gem only supports a subset of the Pivotal API. See below for some examples of what's possible now.

Before you get started, you'll need to set a couple of environment variables:

`export PIVOTAL_TOKEN="YOUR API TOKEN GOES HERE"`

`export PIVOTAL_PROJECT_ID="PIVOTAL PROJECT ID GOES HERE"`

## Structure:
Several of the classes defined in Pivotal inherit from Pivotal::API. The API class defines methods like `where` and `create`
so that any child class can support common queries. Think ActiveRecord.

## Supported Ruby versions
For the most up to date list of supported Ruby versions check the [Travis CI page](https://travis-ci.org/joedursun/pivotal)

## Usage

### Stories:
To find by id:
```ruby
Pivotal::Story.where(id: 123456789)
# => [#<Pivotal::Story:0x007fd032e6fe88 @kind="story", @id=123456789, @created_at="2016-01-23T05:17:46Z"...]
```

You can fetch many at one time:
```ruby
filters = {with_state: :accepted, with_story_type: :bug, limit: 10}
Pivotal::Story.where(filters)
```

Each of the story attributes that come back from Pivotal's API can be accessed via attr_readers so you can do things like:
```ruby
filters = {with_label: :urgent}
Pivotal::Story.where(filters).sort_by(&:accepted_at).last.name
```

Now that you have a story, you can add a label (each call to `add_label` will make a Post request):
```ruby
filters = {with_state: :accepted, with_story_type: :chore, limit: 10}
Pivotal::Story.where(filters).each {|s| s.add_label('whatever label name')}
```

[Here are the docs](http://www.pivotaltracker.com/help/api/rest/v5#Stories) for what search params can be used to find stories.

### Projects:
All of the queries for `Story` above are equally valid (with the exception of filter names; see the appropriate Pivotal docs page).

On top of the usual queries, there are a few convenience methods to help automate deployments.

To find all accepted and unreleased stories:
```ruby
Pivotal::Project.accepted_unreleased_stories
# => [#<Pivotal::Story:0x007fd032e6fe88 @kind="story", @id=123456789, @created_at="2016-01-23T05:17:46Z"...]
```

When it's time for deploying to production you can create a new release marker and label for all of your stories that have
gone out:

```ruby
Pivotal::Project.update_for_release('New Release Label Goes Here')
```

### Releases

If you want to get the most recent release:
```ruby
Pivotal::Release.most_recent
# => #<Pivotal::Release:0x007fd032e6fe88 @kind="release", @id=123456789, @accepted_at="2016-01-23T05:17:46Z"...
```

By default `most_recent` searches only for releases in the last two weeks. If it's been a while since the last release,
just provide a sufficient number of days back to use in the search:
```ruby
Pivotal::Release.most_recent
# => nil
Pivotal::Release.most_recent(30)
# => #<Pivotal::Release:0x007fd032e6fe88 @kind="release", @id=123456789, @accepted_at="2016-01-03T22:34:16Z"...
```

Suppose you have stories that are going to be deployed with your release and you want to add a label to all of them:
```ruby
ready_to_deploy_stories = Pivotal::Project.accepted_unreleased_stories
release = Pivotal::Release.new(label: 'label_for_release', stories: ready_to_deploy_stories)
# The following param is optional. If not provided, then the release label is used.
release.add_label_to_stories('Label to accompany release')
```
