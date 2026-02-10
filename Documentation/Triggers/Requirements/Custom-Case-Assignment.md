Scenario — Custom Case Assignment Matrix
Business Requirement

## Business Case

A Training Institute Support Center wants to assign Cases dynamically based on multiple parameters:

- Inquiry Type (Course / Vendor / Student Support)
- Course Category (Admin / Developer / Integration)
- Customer Tier (Standard / Premium)
- Region (APAC / EMEA / US)
- Case Priority

Because assignment depends on multiple combined conditions, the business wants an Assignment Matrix table that admins can update without changing rules.

## Why Standard Assignment Rules Are Not Enough

**Standard Assignment Rules limitations:**

* Limitation	Impact
* Hard-coded rule entries	Hard to maintain
* No dynamic lookup from table	Cannot use matrix logic
* Complex multi-criteria logic difficult	Rules become very long
* Admin changes require rule restructuring	Maintenance heavy

Therefore organizations implement:

Custom Assignment Matrix Object + Apex Trigger
