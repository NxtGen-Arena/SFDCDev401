public with sharing class InstituteController {

@AuraEnabled(cacheable=true)

public static List<Account> getInstitutes(){

return[
SELECT Id,
Name,
Type,
Phone
FROM Account
LIMIT 10
];

}

}
