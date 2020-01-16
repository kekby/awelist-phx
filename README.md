# AwesomeList

To start application:

  * Install Docker: https://docs.docker.com/install/
  * Start Docker container:
    ```sh
    docker-compose run web mix phx.new . --app awesome_list
    ```
  * Create database for dev:
    ```sh
    docker-compose run web mix ecto.create
    ```
    and for test:
    ```sh
    docker-compose run web mix ecto.create
    ```
  * Run application: 
    ```sh
    docker-compose up -d
    ```

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
