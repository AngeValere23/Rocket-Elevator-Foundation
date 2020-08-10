# README
## How to test Twilio  
Elevator ID 20 is associated with Patrick Thibault phone number (Tech Phone)  
https://martindussault.com/backoffice/elevator/20/edit
Change status to Intervention  
Elevator ID 19 is associated with Mathieu House phone number (Tech Phone)  
https://martindussault.com/backoffice/elevator/19/edit  
Change status to Intervention  
  
This would also test Slack api


## How to do Query with GraphQL
Endpoint : ``https://martindussault.com/graphql``, using POST

### 1. Get intervention with address, start and end date
```
query {
 intervention(id: 1) {
    id
    interventionStart
    interventionEnd
    building {
      id
      address {
        id
        city
        country
        entity
        numberAndStreet
        status
        suiteOrAppart
        typeOfAddress
      }
    }
  }
 }
```

### 2. Get client informations and interventions from a building
```
query {
building(id: 1) {
    id
    customer {
      id
      companyName
      companyPhone
      emailOfContact
      fullNameOfContact
      fullNameOfServiceTechAuthority
      technicalAuthorityEmail
      technicalAuthorityPhone
    }
    interventions {
      id
      interventionEnd
      interventionStart
  }
 }
```

### 3. Get all interventions and building details from an employee
```
query {
employee(id: 7) {
    id
    title
    lastName
    firstName
    interventions {
      id
      interventionStart
      interventionEnd
      building {
        id
        buildingDetail {
          id
          key
          value
        }
      }
    }
  }
}
```

## How to connect to the backoffice

You need to connect with a employee account, all default employee are in db/seeds.rb. All the employee have the same default password `rocket`.

## Connect the warehouse

To setup the warehouse you have to edit the `/config/database.yml` and the postgres section.
You can migrate the database via `DB=warehouse rake db:reset db:migrate`, db:reset is not optional

## Seed the warehouse

To take the data from the MySQL database to the warehouse you can use a one line command (yes really :) )
You can use `rake warehouse:seed` be aware that the comment remove EVERYTHING from the warehouse
