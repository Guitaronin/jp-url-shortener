# Intial Setup

    docker-compose build
    docker-compose up mariadb
    docker-compose run jp-url-shortener rails db:migrate
    docker-compose -f docker-compose-test.yml build

# To run migrations

    docker-compose run jp-url-shortener rails db:migrate
    docker-compose -f docker-compose-test.yml run jp-url-shortener-rspec rails db:test:prepare

# To run the specs

    docker-compose -f docker-compose-test.yml run jp-url-shortener-rspec

# Run the web server

    docker-compose up

# Adding a URL

    curl -X POST -d "full_url=https://google.com" http://localhost:3000/short_urls.json

# Getting the top 100

    curl localhost:3000

# Checking your short URL redirect

    curl -I localhost:3000/abc
    
# Algorithm description for shortening the URLs

I am using a [Bijective Function](https://en.wikipedia.org/wiki/Bijection) to accomplish the shortening of the URLs.
The Bijective Function algorithm was taken from this [Post](https://www.geeksforgeeks.org/how-to-design-a-tiny-url-or-url-shortener/). 
It basically converts a Base 10 number in this case the URL record ID in the database to a Base 62 number, from this point
it uses the resulted number in Base 62 as the index for searching the actual corresponding characters for the shortening.
