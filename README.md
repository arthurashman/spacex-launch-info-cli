# SpaceX Launch Info CLI

SpaceX Launch Info is a CLI that accepts a year and rocket name, and displays the flights of that rocket for the given year. The display shows Flight number, Flight date, Rocket name, Launch site and 

### Getting started

Fork or clone this repo:      
```
> git clone git@github.com:arthurashman/spacex-launch-info-cli.git
> gem install bundle    
> bundle  
```

### Usage
```
> ruby spacex_launch_info_cli.rb
```

### User Stories
```
As a user running the application
I can view a list of rocket launches for a user submitted year and rocket ID
So that I know what launches have taken place
```
### ACs
```
For the known year and rocket ID, 2016 and Falcon 9 respectively, results are returned.
The Launch Date, Rocket Name, Details and Long Launch Site Name are displayed.
Log when a request is made to the SpaceX API and the latency of the response.
```