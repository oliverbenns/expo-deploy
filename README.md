# Expo Deploy

Bash script to deploy to different [Expo](https://expo.io) environments.

## Setup

  - `npm install exp -g`
  - Place the deploy script in your root directory
  - Add the relevant config files as shown in this example repository

## Usage

  - *Publish:* `./deploy publish [environment]`
  - *Build:* `./deploy build [environment]` (builds both IPA + APK files)

### Local Exp

It's also possible to have [exp](https://github.com/expo/exp) installed locally. To do this:

  - `npm install exp --save-dev`
  - In your `package.json`, call the shell script through npm scripts. This is how I do it:
    - ```
        "publish": "chmod +x ./deploy.sh && ./deploy.sh publish $ENVIRONMENT",
        "build": "chmod +x ./deploy.sh && ./deploy.sh build $ENVIRONMENT"
      ```
    - Run with`--ENVIRONMENT=staging npm run publish` or `--ENVIRONMENT=staging npm run build`
