# AwesomeList

## Contents:

  - [Prerequisites](#prerequisites)
  - [Important notes](#important-notes)
  - [How to run](#how-to-run)
  - [Make commands](#make-commands)

## Prerequisites

- First, read the [notes](#important-notes).
- make (for automatic installation)
- Docker: https://docs.docker.com/install/ and docker-compose: https://docs.docker.com/compose/install/
- Get an access token from [Github](https://help.github.com/en/github/authenticating-to-github/creating-a-personal-access-token-for-the-command-line)
- Create `config/dev.secret.exs` file and place your token. For reference, see `config/dev.secret.example.exs`. 

## Important notes
  - Fetching to Github API runs via scheduler on very first startup. It is recommended to wait until task is done, so scheduler can log successfull task in database.
  - 404 HTTP status in console is fine. Just outdated repositories.
  - 403 HTTP possibly means that app is exceeded Github API limitations. In this case tests would fail. Need to figure out how provide to Bypass external Github URL's.

## How to run:

  You can simply run shortcuts:

  ```sh
    make install
  ```

  and if you're ready:

  ```sh
    make run
  ```

These commands is simply shortcuts for:

  * Get dependencies:
    ```sh
    docker-compose run web mix deps.get
    ```
  * Create database:
    ```sh
    docker-compose run web mix ecto.create
    ```
  * Apply migrations
    ```sh
    docker-compose run web mix ecto.migrate
    ```
  * install assets: 
    ```sh
    cd assets && npm install && cd ..
    ```
  * Run application: 
    ```sh
    docker-compose up
    ```




### Make commands
Other useful commands:
```sh
  make compose-test # run tests
```

```sh
  make compose-kill
```

```sh
  make compose-bash
```

```sh
  make compose-iex
```

```sh
  make compose-migrate
```


Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.
