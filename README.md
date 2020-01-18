# AwesomeList

## Prerequisites

- Docker: https://docs.docker.com/install/ and docker-compose: https://docs.docker.com/compose/install/
  
To start application:

  * Get dependencies:
    ```sh
    docker-compose run web mix deps.get
    ```
  * Create database for dev:
    ```sh
    docker-compose run web mix ecto.create
    ```
    and for test:
    ```sh
    docker-compose run test mix ecto.create
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



Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
