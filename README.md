# Weather Dashboard on SF Experience Cloud
![example workflow](https://github.com/pelayochristian/my-weather-app/actions/workflows/push-development-branch.yml/badge.svg)
## Introduction
Created as a side project, intends to learn integration in Salesforce Platform by building a Weather Dashboard app that consumes web-service from OpenWeather API. This app is built on top of the Salesforce Experience Cloud (Community Page) using LWR Template. 

Tech Stack:
- [x] LWC
- [x] Apex

![](demo.gif)

## Deployment
1. Clone the my-weather-app repository
```
git clone https://github.com/pelayochristian/my-weather-app.git
cd my-weather-app:
```
2. Authorize the project in your dev org and provide it with and alias (**mydevorg** in the command below):
```
sfdx auth:web:login -d -a mydevorg
```
3. Deploy the project by providing the authorize user from above (**mydevorg**):
```
sfdx force:source:deploy -p force-app -u mydevorg
```