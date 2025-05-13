/***
 * Demo for actionFunction:
 * Region → Subregion (dependent picklist logic using <apex:actionFunction>)
 * Case Status as an additional filter
 * Search button filters results based on selected filters
 * Pagination (Next, Previous) for case results display
 */

public with sharing class CaseSearchController {
    public String selectedRegion { get; set; }
    public String selectedSubRegion { get; set; }
    public String selectedStatus { get; set; }

    public List<SelectOption> regionOptions { get; set; }
    public List<SelectOption> subRegionOptions { get; set; }
    public List<SelectOption> statusOptions { get; set; }

    public List<Case> caseResults { get; set; }
    public Integer pageSize = 5;
    public Integer pageNumber {get;set;}
    

    public CaseSearchController() {
        pageNumber = 0;
        loadRegions();
        subRegionOptions = new List<SelectOption>();
        loadStatusOptionsFromSchema();
        loadSubRegions(); // initialize
        searchCases();
    }
    /**
     * @Description: Populate sttaic selection options for region
     * @return: void
     * @param: NA
     */
    public void loadRegions() {
       regionOptions = new List<SelectOption>{new SelectOption('', '-- Select One --')};

       regionOptions.add(new SelectOption('EMEA', 'EMEA'));

       regionOptions.add(new SelectOption('APAC', 'APAC'));

       regionOptions.add(new SelectOption('AMERICAS', 'AMERICAS'));
    }

    /**
     * @Description: Dynamically retrieve the subregions based on the region selected
     * @return: void
     * @param: NA
     */
    public void loadSubRegions() {
        subRegionOptions.clear();
        subRegionOptions.add(new SelectOption('', '-- Select One --'));
        if (selectedRegion == 'EMEA') 
        {
            subRegionOptions.add(new SelectOption('UK', 'UK'));
            subRegionOptions.add(new SelectOption('France', 'France'));
            subRegionOptions.add(new SelectOption('Germany', 'Germany'));
        } else if (selectedRegion == 'APAC') 
        {
            subRegionOptions.add(new SelectOption('India', 'India'));
            subRegionOptions.add(new SelectOption('Japan', 'Japan'));
            subRegionOptions.add(new SelectOption('Australia', 'Australia'));
        } else if (selectedRegion == 'AMERICAS') {

            subRegionOptions.add(new SelectOption('USA', 'USA'));
            subRegionOptions.add(new SelectOption('Canada', 'Canada'));
            subRegionOptions.add(new SelectOption('Brazil', 'Brazil'));
        }
    }

    /**
     * @Description: Dynamically retrieve the case status options from Case object using schema
     * @return: void
     * @param: NA
     */
    public void loadStatusOptionsFromSchema() {
        statusOptions = new List<SelectOption>();
        statusOptions.add(new SelectOption('', '-- Select One --'));
        Schema.DescribeFieldResult fieldDesc = Case.Status.getDescribe();
        for (Schema.PicklistEntry entry : fieldDesc.getPicklistValues()) {
            statusOptions.add(new SelectOption(entry.getValue(), entry.getLabel()));
        }
    }

    /**
     * @Description: Search cases based on the filter criteria
     * @return: void
     * @param: NA
     */
    public void searchCases() {
        String query = 'SELECT Id, CaseNumber, Subject, Status FROM Case WHERE Id != null';
        if (selectedRegion != null) query += ' AND Region__c = :selectedRegion';
        if (selectedSubRegion != null) query += ' AND Subregion__c = :selectedSubRegion';
        if (selectedStatus != null) query += ' AND Status = :selectedStatus';

        //Offset: Number of records to skip. Used for pagination
        query += ' ORDER BY CreatedDate DESC LIMIT :pageSize OFFSET :pageNumber';

        caseResults = Database.query(query);
    }

    /**
     * @Description: Pagination methods for next and previous display of case results
     * @return: void
     * @param: NA
     */
    public void nextPage() {
        pageNumber += pageSize;
        searchCases();
    }

    public void previousPage() {
        pageNumber = Math.max(0, pageNumber - pageSize);
        searchCases();
    }
}
