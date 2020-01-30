# AwesomeList

## Prerequisites

- make (for automatic installation)
- Docker: https://docs.docker.com/install/ and docker-compose: https://docs.docker.com/compose/install/
- Get an access token from [Github](https://help.github.com/en/github/authenticating-to-github/creating-a-personal-access-token-for-the-command-line)
- Create `config/dev.secret.exs` file and place your token. For reference, see `config/dev.secret.example.exs`. 


To start application:

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

### OR:

You can simply run shortcuts:
```sh
  make install
  make run
```

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

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
