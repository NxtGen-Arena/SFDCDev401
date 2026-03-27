# Aggregate Queries in Salesforce

Aggregate queries in Salesforce Object Query Language (SOQL) allow you to perform calculations like COUNT(), SUM(), AVG(), MIN(), and MAX() on records without retrieving each individual record. These queries are useful when you need summarized data instead of raw details.

<h2>Key Aggregate Functions</h2>

|Function|Description|example
|--------|-----------|--------|
| COUNT() | Returns the number of records.|SELECT COUNT() FROM Account
| SUM(field)| Returns the total sum of a numeric field.| SELECT SUM(Amount), AVG(Amount) FROM Opportunity WHERE StageName = 'Closed Won'
| AVG(field) | Returns the average value of a numeric field.|SELECT SUM(Amount), AVG(Amount) FROM Opportunity WHERE StageName = 'Closed Won'
| MIN(field) | Returns the minimum value of a field.|SELECT MIN(Amount), MAX(Amount) FROM Opportunity
| MAX(field) | Returns the maximum value of a field.|SELECT MIN(Amount), MAX(Amount) FROM Opportunity

<h3>What else Can I Do with Aggregate Functions</h3>

### Grouping and Aggregating (GROUP BY ROLLUP)

To get a breakdown of Opportunities per StageName and a grand total.This provides totals for each StageName, plus a grand total row.

```
SELECT StageName, SUM(Amount) FROM Opportunity GROUP BY ROLLUP(StageName)
```

### Filtering Aggregated Results (HAVING)

The HAVING clause filters groups based on aggregate functions.
Find all industries with more than 10 Accounts:

```
SELECT Industry, COUNT(Id) FROM Account GROUP BY Industry HAVING COUNT(Id) > 10
```

<h2>Processing AggregateResults in Apex</h2>

The AggregateResult object holds grouped data. .get('FieldName') is used to retrieve values.

```
public void aggregateExample() {
    AggregateResult[] results = [SELECT Industry, COUNT(Id) count FROM Account GROUP BY Industry];
    
    for (AggregateResult ar : results) {
        System.debug('Industry: ' + ar.get('Industry') + ', Count: ' + ar.get('count'));
    }
}
```

<h2>Limitations of Aggregate Queries</h2>

1. Maximum Rows Returned: Aggregate queries return a maximum of 50,000 records.
2. GROUP BY Limitations: Up to 200 unique groups are allowed.
3. Dynamic Field Access: You must use ar.get('FieldName') instead of direct access.


<h2>Use Cases</h2>

* Reporting & Dashboards: Extract summarized data for reports.
* Data Cleanup: Identify duplicate or unused records.
* Performance Optimization: Reduce query time by fetching only necessary summary data.
