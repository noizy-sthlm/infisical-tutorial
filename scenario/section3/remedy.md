# Secrets Management

what we will do now:

## Setting Up Infisical

### Create Infisical Account

First, we need to create a free account with Infisical to access their scanning services:

   - Visit [infisical.com](https://infisical.com) 
   - Create a free account to get started (We recommend sign up using Europe data region)
   - This will give you access to Infisical's cloud-based scanning services

next: create keys that will replace the keys from Step 1. use DEV and PRODUCTION for the tutorial

for this tutorial, create new keys in infisical 

for DEV
- API_KEY = "sk-1234567890abcdef-DEV";
- DB_PASSWORD = "mypassword123-DEV";
- JWT_SECRET = "super-secret-jwt-key-DEV";

for PRODUCTION
- API_KEY = "sk-1234567890abcdef-PROD";
- DB_PASSWORD = "mypassword123-PROD";
- JWT_SECRET = "super-secret-jwt-key-PROD";

then change the keys into the following. copy paste
- process.env.API_KEY 
- process.env.DB_PASSWORD 
- process.env.JWT_SECRET

next is to get the keys from Infisical during run time

open INfisical CLI

infisical login

still in infisical-tutorial holder
# initialize infisical
infisical init

infisical run --env=dev npm start

you will see they key from infisical

infisical run --env=prod npm start

now in different environment, you can see it as well

----

we have now demonstrated how you can securely save your secrets using Insifical. 