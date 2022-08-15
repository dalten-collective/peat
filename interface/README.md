# README

## Dev setup

- Create a `.env` file within `interface/` following the example in
`env.example`
- From the root of the project (the whole project, not `interface`), use the
`bin/` scripts to control the dev server:
  - `bin/install-js-dependencies.sh` will install all the js dependencies.
  - `bin/serve-interface.sh` will start the Vite dev server. Visit the URL shown
  once this starts (don't forget the trailing slash at the end of the url)
  - `bin/watch-urbit.sh` will continually copy the relevant urbit files to a
  pier that you specify.

