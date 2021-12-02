# advent-of-code

Solutions to each years Advent of Code problems! I look forward to this almost more than Christmas! 

## Solving a problem

First create a .env file like the following

``` sh
SESSION_COOKIE=<your cookie here>
```

I've been using the Dockerfile to so I can use the latest version of Ruby, which I don't have installed locally

``` sh
./scripts/build.sh # Builds the docker image and installs useful gems
./scripts/shell.sh # Drops you into a docker container ready to solve with all the latest ruby greatness
```

Then you can run commands like the following: 

``` sh
./solve -d 1 -g   # Pull the input and generate file for solving
./solve -d 1      # Run test cases against solution, if pass can submit
./solve -d 1 -s   # Solve problem, but skip test cases
./solve --help    # See all options available
```

