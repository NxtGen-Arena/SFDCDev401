## Business Requirement Recap

Object: Account
Scenario: When Account Phone is updated
Action: Update Phone on all related Contacts

Constraints:

- Only when Phone actually changes
- Bulk-safe
- Well-commented
- No SOQL/DML inside loops

🧩 Solution Design (Best Practice)

Trigger

* Only delegates work
* No business logic
* Handler Class
* Compares old vs new values
* Queries related Contacts in bulk
* Updates them in one DML
