
[![Contributors][contributors-shield]][contributors-url]
[![LinkedIn][linkedin-shield]][linkedin-url]

# Rails Engine

<!-- TABLE OF CONTENTS -->
<details open="open">
  <summary><h2 style="display: inline-block">Table of Contents</h2></summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#learning-goals">Learning Goals</a></li>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#database-schema">Database Schema</a></li>
    <li><a href="#testing">Testing</a></li>
    <li><a href="#contact">Contact</a></li>
  </ol>
</details>


## About The Project

Rails Engine is an E-Commerce Application using a service-oriented architecture. The front and back ends of this application are separate and communicate via APIs. The main objective of this project is to expose the data that powers the site through various API endpoints that the front end will consume.

### Learning Goals

- Expose an API
- Test API exposure
- Use serializers to format JSON responses
- Compose advanced ActiveRecord queries to analyze information stored in SQL databases
- Write SQL statements without the assistance of an ORM

### Built With

* [Ruby 2.5.3](https://backend.turing.io/module3/misc/ruby_and_rails_versions)
* [Rails 5.2.4.3](https://backend.turing.io/module3/misc/ruby_and_rails_versions)

<!-- GETTING STARTED -->
## Getting Started

- In your terminal, create a directory called  `rails-engine`
  ```sh
  mkdir rails-engine
  ```
- Next you will want to `cd` into this new directory
```sh
cd rails-engine
```

### Installation

1. Fork this repo and put it into your `rails-engine` directory
   ```sh
   git clone git@github.com:github_username/rails-engine.git
   ```
   - `cd` into your forked repo and open up atom
   - You will then run `bundle install` to load all of the gems
   - Then you will need to run:
    - `rake db:{create,migrate,seed}`; This will create, migrate and seed your database
2. You will also need to put the Front end portion of this project (Rails Driver) into the `rails-engine` directory you created
  - Fork [this](https://github.com/turingschool-examples/rails_driver) repo
   ```sh
   git clone git@github.com:github_username/rails_driver.git
   ```
   - `cd` into your forked repo and open up atom
   - follow the set up instructions located in the README
3. Since this is using service-oriented architecture, you will need to run both of these simultaneously. I found that having four separate tabs open in my terminal helps with this. So you will have your `rails-engine` running in one tab, you will then run `rails s` in another tab. You will want to have `rails_driver` open in another tab and in your final tab you will run `rails s -p 3001`.
```sh
rails-engine -> rails s
```
```sh
rails_driver -> rails s -p 3001
```  

<!-- USAGE EXAMPLES -->
## Usage

In this project you will be building multiple endpoints for merchants and items. To see what these endpoints should look like and implement them, you can refere to the `rails-engine-postman_collection.json` file located in the file tree and import that into Postman.

## Database Schema

Below you will see a diagaram showing the relationships for all of the tables

![rails-engine](https://user-images.githubusercontent.com/60626984/102558905-c71b0280-408b-11eb-9252-b1816d72f428.png)

<!-- ROADMAP -->
## Testing

For this project you will need to run the tests for both your `rails-engine` and also run the spec harness tests for `rails_driver`.
The tests for `rails-engine` will be written by you using OOP, encapsulation and abstraction. We want to make sure that we are using SRP.
```sh
rails-engine will use rails s
```
The tests for `rails_driver` have already been written.
```sh
rails_driver will use rails s -p 3001
```
Both consoles will be running simultaneously. You will use the following command to run the tests:
```sh
bundle exec rspec
```

<img width="625" alt="rails-engine test coverage" src="https://user-images.githubusercontent.com/60626984/102561159-36472580-4091-11eb-8fa3-45a3cd14a13c.png">

<!-- CONTACT -->
## Contact

Dani Coleman - [LinkedIn](https://www.linkedin.com/in/dcoleman-21/)

Project Link: [Rails Engine](https://github.com/dcoleman21/rails-engine)



<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/dcoleman21/rails-engine.svg?style=for-the-badge
[contributors-url]: https://github.com/dcoleman21/rails-engine/graphs/contributors

[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://linkedin.com/in/dcoleman-21/
