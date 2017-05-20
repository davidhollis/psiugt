# psiugt.org

This application drives the website for Psi Upsilon's Gamma Tau chapter.

## Setup

To set up for development, ensure you've installed [rvm] and [ruby 2.3.0], then from the repository root, run the following to set up a development database:

```
bundle install
rake db:migrate
rake casein:users:create_admin email=you@yourdomain.com password=your_password
```

The password will only be used for local development, so it does not need to be secure.