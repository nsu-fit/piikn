# Малые отношения для практики 5.5

## Airports

| airport_code | city | country |
|---|---|---|
| OVB | Novosibirsk | Russia |
| DME | Moscow | Russia |
| LED | Saint Petersburg | Russia |
| ALA | Almaty | Kazakhstan |

## Routes

| route_no | departure_airport | arrival_airport |
|---|---|---|
| R1 | OVB | DME |
| R2 | DME | LED |
| R3 | OVB | ALA |
| R4 | LED | OVB |

## Flights

| flight_id | route_no | status |
|---|---|---|
| F101 | R1 | Scheduled |
| F102 | R2 | Scheduled |
| F103 | R3 | Cancelled |

## Tickets

| ticket_no | passenger_name |
|---|---|
| T1 | Ada Lovelace |
| T2 | Grace Hopper |
| T3 | Donald Knuth |
| T4 | Barbara Liskov |

## Segments

| ticket_no | flight_id |
|---|---|
| T1 | F101 |
| T1 | F102 |
| T2 | F102 |
| T3 | F101 |
| T3 | F102 |
| T3 | F103 |

## RequiredFlights

| flight_id |
|---|
| F101 |
| F102 |
