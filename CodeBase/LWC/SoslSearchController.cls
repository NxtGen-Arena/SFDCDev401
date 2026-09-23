/**
 * SoslSearchController
 * ---------------------
 * Thin Apex layer behind the globalSearch LWC. This exists because SOSL
 * is NOT part of the LDS surface (lightning/uiRecordApi has no multi-object
 * search entry point) — everything else in the companion component
 * (object metadata, labels) genuinely goes through LDS/UI API instead.
 *
 * Design notes for the demo:
 * - cacheable=true so the wire adapter on the LWC side behaves reactively,
 *   the same caching/re-render behavior trainees just saw with LDS.
 * - Field list per object is an explicit allow-list, not '*' — keeps the
 *   RETURNING clause predictable and prevents an accidental wide field
 *   exposure via a dynamically built query.
 * - WITH SECURITY_ENFORCED enforces field-level security at query time;
 *   a field the running user can't see throws instead of silently leaking.
 * - Search term is sanitized to strip SOSL reserved characters before
 *   being interpolated into the query string.
 */
public with sharing class SoslSearchController {

    private static final Integer MAX_RESULTS_PER_OBJECT = 200;

    // Explicit, safe field list per searchable object. Extend this map to
    // add more objects to the picker — the LWC's OBJECT_CONFIG must match.
    private static final Map<String, List<String>> OBJECT_FIELDS = new Map<String, List<String>>{
        'Account'     => new List<String>{ 'Id', 'Name', 'Industry', 'Phone', 'BillingCity' },
        'Contact'     => new List<String>{ 'Id', 'FirstName', 'LastName', 'Email', 'Phone', 'Account.Name' },
        'Lead'        => new List<String>{ 'Id', 'FirstName', 'LastName', 'Company', 'Email', 'Status' },
        'Opportunity' => new List<String>{ 'Id', 'Name', 'StageName', 'Amount', 'CloseDate' }
    };

    @AuraEnabled(cacheable=true)
    public static List<SObject> searchRecords(String searchTerm, String objectApiName) {
        if (String.isBlank(searchTerm) || String.isBlank(objectApiName)) {
            return new List<SObject>();
        }
        if (!OBJECT_FIELDS.containsKey(objectApiName)) {
            throw new AuraHandledException('Unsupported search object: ' + objectApiName);
        }

        String cleanedTerm = sanitizeSearchTerm(searchTerm);
        if (cleanedTerm.length() < 2) {
            return new List<SObject>();
        }

        String fieldList = String.join(OBJECT_FIELDS.get(objectApiName), ', ');

        String soslQuery =
            'FIND \'' + String.escapeSingleQuotes(cleanedTerm) + '*\' IN ALL FIELDS ' +
            'RETURNING ' + objectApiName + '(' + fieldList +
            ' WITH SECURITY_ENFORCED LIMIT ' + MAX_RESULTS_PER_OBJECT + ')';

        try {
            List<List<SObject>> results = Search.query(soslQuery);
            return results.isEmpty() ? new List<SObject>() : results[0];
        } catch (System.QueryException qe) {
            throw new AuraHandledException('Search failed: ' + qe.getMessage());
        }
    }

    // Strips SOSL reserved characters so a term like "O'Brien & Co?" can't
    // produce a malformed FIND clause. Keeps letters, numbers, spaces.
    private static String sanitizeSearchTerm(String term) {
        String cleaned = term.replaceAll(
            '[\\?\\&\\|\\!\\{\\}\\[\\]\\(\\)\\^\\~\\*\\:\\"\\\'\\+\\-]', ' '
        );
        return cleaned.trim();
    }
}
