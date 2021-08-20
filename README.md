# Twittier

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
