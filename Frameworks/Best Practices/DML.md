# DML best practices

1. Clear list before performing inserts. Else dml execption for records with ID may be thrown.
2. Never place DML inside for loops. Use Collections and DML statements only after the loop is complete. Perform DML on the collection of records
