# Twittier

## Table of Content
| Content |
| ----------- |
| [Brief Description](#brief-description) |
| [How Clone The Repo](#clone-this-repo-first-before-doing-any-other-steps-below) |
| [Requirements to Run The App](#requirements-to-run-the-app-locally) |
| [Commands Before Run The App](#steps-to-do-before-run-the-app) |
| [Run Tests and App](#run-tests-suit-and-application) |
| [API Testing](#api-testing) |
| [API Documentation](#api-documentation) |

## Brief Description
Twittier is created as a social media application which can be used to share information with other people. This application will only be used by people that work in a certain company so we cannot use existing public social media.

## Clone This Repo First Before Doing Any Other Steps Below
- `git clone https://github.com/TjandraD/twittier`
- Change your current directory to this project directory `cd {path to the project directory}`

## Requirements to Run The App Locally
- MySQL (check this [link](https://www.digitalocean.com/community/tutorials/how-to-install-mysql-on-ubuntu-20-04) for the installation process)
  ```
  sudo apt update
  sudo apt install mysql-server libmysqlclient-dev
  ```
- Ruby (go check [rbenv](https://github.com/rbenv/rbenv#using-package-managers) for installing Ruby)
- Bundler (check this [link](https://bundler.io/) for installation process)

## Steps to Do Before Run The App
- Create MySQL Database
  - Type `mysql` in your terminal
  - Once you get inside the MySQL CLI, type `CREATE DATABASE {your preferred database name}`
  - Exit the MySQL CLI by typing `exit`
  - Import the database schema `mysql -u {your MySQL username} {your database name} < db_twittier.sql`, make sure your current working directory is inside this project directory
- Install the required gem `bundle install`
- Create .env file based on the skeleton at .env.example

## Run Tests Suit and Application
- Run Tests `rspec`
- Run The App `ruby main.rb`

## API Testing
For this project, Postman Collection was used to test the API endpoints.
- Go check the collection file at [this link](https://github.com/TjandraD/twittier/blob/main/Twittier.postman_collection.json)
- Import that file into your Postman (Go check [Importing data into Postman](https://learning.postman.com/docs/getting-started/importing-and-exporting-data/#importing-data-into-postman))
- Add environment variables containing the root url into Postman (check [Variables quick start](https://learning.postman.com/docs/sending-requests/variables/#variables-quick-start))
  - Set value to `http://35.243.114.125:4567/api` for the production url
  - If you would like to run it locally, set the value to `127.0.0.1:4567/api`
- Run the API Tests (using [Collection Runner](https://learning.postman.com/docs/running-collections/intro-to-collection-runs/#starting-a-collection-run))

## API Documentation
For a detailed documentation for this API, go check this [Postman Documentation](https://documenter.getpostman.com/view/10176261/TzzDHuWw)
