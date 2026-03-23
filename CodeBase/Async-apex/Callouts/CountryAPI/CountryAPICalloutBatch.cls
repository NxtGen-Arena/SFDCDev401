global class CountryAPICalloutBatch implements Database.Batchable<SObject>, Database.AllowsCallouts {

    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator([
            SELECT Id, AlphaCode__c FROM Country__c WHERE CountryName__c = null
        ]);
    }

    global void execute(Database.BatchableContext bc, List<Country__c> scope) {
        Http http = new Http();

        for (Country__c c : scope) {
            if (String.isNotBlank(c.AlphaCode__c)) {
                String url = 'https://restcountries.com/v3.1/alpha/' + c.AlphaCode__c;

                HttpRequest req = new HttpRequest();
                req.setEndpoint(url);
                req.setMethod('GET');
                req.setTimeout(2000);

                try {
                    HttpResponse res = http.send(req);
                    if (res.getStatusCode() == 200) {
                        // Parse JSON to get the common name
                        List<Object> jsonList = (List<Object>) JSON.deserializeUntyped(res.getBody());
                        Map<String, Object> countryMap = (Map<String, Object>) jsonList[0];
                        Map<String, Object> nameMap = (Map<String, Object>) countryMap.get('name');

                        c.CountryName__c = (String) nameMap.get('common');
                    }
                } catch (Exception e) {
                    System.debug('Callout failed for: ' + c.AlphaCode__c + ' | Error: ' + e.getMessage());
                }
            }
        }

        update scope;
    }

    global void finish(Database.BatchableContext bc) {
        System.debug('✅ Country data enrichment complete.');
    }
}
