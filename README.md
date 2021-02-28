# Voting Server

An Voting Server to determine an issue about Wuhan Coronavirus: determining whether Wuhan Coronavirus is created by China.
The user can vote agree or disagree at any time.

## Setup

- Ruby 2.7.2
- Database: SQLite
- run `bundle install` to install gems and node modules
- run `bundle exec rails db:migrate`
- run `bundle exec rails db:seed` to seed users and issue

## Usage

### Authentication

- `POST /api/sign_up` with `email`, `password`
    - e.g. `curl -X POST "127.0.0.1:3000/api/sign_up" -d "email=new@test.test&password=mypass"`
- `POST /api/login` with `email`, `password` to get `auth_token`
    - e.g. `curl -X POST "127.0.0.1:3000/api/login" -d "email=user1@test.test&password=mypass"`

### Vote

- `GET /api/issues` to get all issues
- `GET /api/issues/:id` to get issue info
    - e.g. `curl -X GET "127.0.0.1:3000/api/issues/1"`
- `PATCH /api/issues/:id` with `auth_token` and `agree` to vote, `agree` is `true` or `false`
    - e.g. `curl -X PATCH "127.0.0.1:3000/api/issues/1" -d "auth_token=pY6m75tJujDFcik1hHKyhY1x&agree=0"` for user1 to vote disagree
    - duplicated vote for the same user on same issues will modify previous results

## Test

```
rspec
```
## Start the Server

```
rails s
```

It will serve on `127.0.0.1:3000` by default.

## Time Spent

2.5 hr
