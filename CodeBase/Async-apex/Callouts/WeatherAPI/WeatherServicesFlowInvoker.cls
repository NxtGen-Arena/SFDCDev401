/**
 * @description Invocable Apex wrapper for WeatherServicesEngineRSS to enable Flow usage.
 * Provides two operations:
 *  - NAMED_CREDENTIAL: Uses getWeatherForCityNamedCred to deserialize JSON into structured fields
 *  - DIRECT: Uses getWeatherForCityRSS and returns raw JSON string
 *
 * Security:
 * - with sharing to respect org sharing rules
 * - No DML or SOQL performed
 *
 * Notes:
 * - Replace the hardcoded API key in WeatherServicesEngineRSS with a Named Credential. This invoker assumes
 *   the underlying engine methods are already configured and reachable.
 */
public with sharing class WeatherServicesFlowInvoker {
    // Use enums over string constants
    public enum OPERATION {
        NAMED_CREDENTIAL,
        DIRECT
    }

    /**
     * @description Flow input structure
     */
    public class Input {
        @InvocableVariable(required=true)
        public String city;

        /**
         * Optional operation selector:
         * - NAMED_CREDENTIAL: calls WeatherServicesEngineRSS.getWeatherForCityNamedCred
         * - DIRECT: calls WeatherServicesEngineRSS.getWeatherForCityRSS
         * Defaults to NAMED_CREDENTIAL when omitted.
         */
        @InvocableVariable(required=false)
        public String operation;
    }

    /**
     * @description Flow output structure
     */
    public class Result {
        @InvocableVariable
        public String city;

        @InvocableVariable
        public String status;

        @InvocableVariable
        public String message;

        // Structured fields (when using NAMED_CREDENTIAL)
        @InvocableVariable
        public String responseCityName;

        @InvocableVariable
        public Decimal temperature;

        @InvocableVariable
        public Integer humidity;

        // Raw JSON (when using DIRECT)
        @InvocableVariable
        public String rawJson;
    }

    /**
     * @description Invocable entry point for Flow. Accepts a list of inputs and returns a list of results.
     * Bulkified: processes all inputs without DML/SOQL or per-item queries.
     */
    @InvocableMethod(label='Get Weather (RSS Engine)' description='Calls WeatherServicesEngineRSS to retrieve weather for a city. Supports Named Credential or Direct call.')
    public static List<Result> invoke(List<Input> requests) {
        List<Result> results = new List<Result>();
        if (requests == null || requests.isEmpty()) {
            return results; // return-early
        }

        for (Input req : requests) {
            Result out = new Result();
            out.city = req != null ? req.city : null;

            try {
                // Resolve operation
                OPERATION op = OPERATION.NAMED_CREDENTIAL;
                if (req != null && String.isNotBlank(req.operation)) {
                    // Map string to enum safely; default to NAMED_CREDENTIAL on mismatch
                    OPERATION parsed;
                    try {
                        parsed = (OPERATION)Enum.valueOf(OPERATION.class, req.operation.trim().toUpperCase());
                        op = parsed;
                    } catch (Exception ign) {
                        op = OPERATION.NAMED_CREDENTIAL;
                    }
                }

                if (String.isBlank(out.city)) {
                    out.status = 'ERROR';
                    out.message = 'City is required.';
                    results.add(out);
                    continue; // return-early for this item
                }

                switch on op {
                    when OPERATION.NAMED_CREDENTIAL {
                        WeatherServicesEngineRSS.WeatherResponse wr = WeatherServicesEngineRSS.getWeatherForCityNamedCred(out.city);
                        if (wr != null) {
                            out.status = 'SUCCESS';
                            out.responseCityName = wr.name;
                            if (wr.main != null) {
                                out.temperature = wr.main.temp;
                                out.humidity = wr.main.humidity;
                            }
                            out.message = 'Weather retrieved via Named Credential.';
                        } else {
                            out.status = 'ERROR';
                            out.message = 'No response received from Named Credential call.';
                        }
                    }
                    when OPERATION.DIRECT {
                        String body = WeatherServicesEngineRSS.getWeatherForCityRSS(out.city);
                        out.status = 'SUCCESS';
                        out.rawJson = body;
                        out.message = 'Weather retrieved via direct HTTP call.';
                    }
                }
            } catch (CalloutException ce) {
                out.status = 'ERROR';
                out.message = 'CalloutException: ' + ce.getMessage();
            } catch (Exception ex) {
                out.status = 'ERROR';
                out.message = 'Exception: ' + ex.getMessage();
            }

            results.add(out);
        }

        return results;
    }
}
