# Project

[github_repos_search.com](https://....com)

Basic Github search powered by Ruby on Rails 7 and Stimulus JS

## Install

### Clone the repository

```shell
git clone git@github.com:tococorocko/github_repos_search.git
cd github_repos_search
```

### Check your Ruby version

```shell
ruby -v
```

The ouput should start with something like `ruby 3.x`

If not, install the right ruby version using [rbenv](https://github.com/rbenv/rbenv) (it could take a while):

```shell
rbenv install 3.1.5
```

### Install dependencies

Using [Bundler](https://github.com/bundler/bundler) and [Yarn](https://github.com/yarnpkg/yarn):

```shell
bundle && yarn
```

### Add heroku remotes

Using [Heroku CLI](https://devcenter.heroku.com/articles/heroku-cli):

```shell
heroku git:remote -a github_repos_search
```

## Serve

```shell
rails s
# or with assets
bin/dev
```

## Specs/tests

```shell
bundle exec rspec
```

## Deploy

Push to Heroku production remote:

```shell
git push heroku
```
