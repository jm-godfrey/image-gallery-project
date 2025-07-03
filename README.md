# Image Gallery Application
This project is a ruby on rails application for creating and sharing galleries of photos. Users can:

- Browse public galleries including guests
- Sign up / log in / log out with devise authentication
- Reset their password
- Manage their galleries if logged in: create, edit and delete
- Upload photos to their galleries using active storage
- See thumbnails of galleries that are precomputed on upload using imagemagick
- Like and save galleries

## Getting Started 

### System Dependencies

- **Ruby Version:** 3.3.4
- **Rails Version:** 7.0.8.7
- **PostgreSQL**
- **Node.js(v14+)**
- **Yarn**
- **ImageMagick**

Ruby gem dependencies are installed via bundle install and javascript via yarn install.

### Running the application

- Clone the repository using:
```
git clone https://github.com/jm-godfrey/image-gallery-project.git
```
- CD into the project: 
```
CD image-gallery-project
```
- To run the project in development mode, use the following commands to set up the system:
```
bin/setup
rake db:setup
```
- Then in 2 seperate terminal instances:
```
bundle exec rails s
bin/shakapacker-dev-server
```
- Then open your browser at: http://localhost:3000

## Testing
To run the tests, run: `bundle exec rspec`

## Additional notes

- Project develeoped as part of a submission for The Curve
- Authored by James Godfrey
