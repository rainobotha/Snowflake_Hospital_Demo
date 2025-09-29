-- ============================================================================
-- Hospital Snowflake Demo - Deploy Streamlit Analytics App
-- ============================================================================
-- This script deploys the Streamlit app in Snowflake's native environment
-- IMPORTANT: Run this script as ACCOUNTADMIN

USE ROLE ACCOUNTADMIN;
USE DATABASE HOSPITAL_DEMO;
USE SCHEMA ANALYTICS;

-- 1. Upload the Streamlit app file to the stage
-- Note: You need to run this PUT command from your local machine first:
-- PUT file://path/to/hospital_analytics_app.py @HOSPITAL_DATA_STAGE;

-- 2. Create the Streamlit app in Snowflake
CREATE OR REPLACE STREAMLIT HOSPITAL_ANALYTICS_APP
ROOT_LOCATION = '@HOSPITAL_DATA_STAGE'
MAIN_FILE = 'hospital_analytics_app.py'
QUERY_WAREHOUSE = HOSPITAL_ANALYTICS_WH
COMMENT = 'Hospital analytics dashboard with role-based access for clinical teams';

-- 3. Grant permissions to different roles
GRANT USAGE ON STREAMLIT HOSPITAL_ANALYTICS_APP TO ROLE CLINICAL_ADMIN;
GRANT USAGE ON STREAMLIT HOSPITAL_ANALYTICS_APP TO ROLE PHYSICIAN;
GRANT USAGE ON STREAMLIT HOSPITAL_ANALYTICS_APP TO ROLE NURSE;
GRANT USAGE ON STREAMLIT HOSPITAL_ANALYTICS_APP TO ROLE ANALYST;

-- 4. Show the created Streamlit app
SHOW STREAMLITS;

-- 5. Get the app URL (will be displayed in the results)
SELECT 'Streamlit app created successfully!' as status_message;
SELECT 'Access the app through your Snowflake web interface under Apps > Streamlit' as access_info;
SELECT 'Each role will see different data based on RBAC policies' as security_info;

-- 6. Optional: Create additional Streamlit apps for specific roles
-- Uncomment if you want role-specific apps

/*
-- Physician-specific app
CREATE OR REPLACE STREAMLIT PHYSICIAN_DASHBOARD_APP
ROOT_LOCATION = '@HOSPITAL_DATA_STAGE'
MAIN_FILE = 'hospital_analytics_app.py'
QUERY_WAREHOUSE = HOSPITAL_ADHOC_WH
COMMENT = 'Physician-specific clinical dashboard';

GRANT USAGE ON STREAMLIT PHYSICIAN_DASHBOARD_APP TO ROLE PHYSICIAN;

-- Nurse-specific app  
CREATE OR REPLACE STREAMLIT NURSE_DASHBOARD_APP
ROOT_LOCATION = '@HOSPITAL_DATA_STAGE'
MAIN_FILE = 'hospital_analytics_app.py'
QUERY_WAREHOUSE = HOSPITAL_ADHOC_WH
COMMENT = 'Nurse operational dashboard';

GRANT USAGE ON STREAMLIT NURSE_DASHBOARD_APP TO ROLE NURSE;
*/

-- 7. Security and governance for Streamlit apps
-- Apply tags to Streamlit apps for governance
ALTER STREAMLIT HOSPITAL_ANALYTICS_APP SET TAG 
    HOSPITAL_DEMO.ANALYTICS.DATA_CLASSIFICATION = 'CLINICAL',
    HOSPITAL_DEMO.ANALYTICS.PHI_INDICATOR = 'YES';

-- 8. Monitor Streamlit app usage (for admins)
-- These queries can be used to monitor app usage:
/*
-- App usage statistics
SELECT 
    app_name,
    user_name,
    role_name,
    session_start_time,
    session_end_time,
    queries_executed
FROM SNOWFLAKE.ACCOUNT_USAGE.STREAMLIT_USAGE_HISTORY
WHERE app_name = 'HOSPITAL_ANALYTICS_APP'
ORDER BY session_start_time DESC;

-- Query performance for Streamlit apps
SELECT 
    query_text,
    execution_time,
    warehouse_name,
    user_name,
    start_time
FROM SNOWFLAKE.ACCOUNT_USAGE.QUERY_HISTORY
WHERE query_tag LIKE '%STREAMLIT%'
  AND database_name = 'HOSPITAL_DEMO'
ORDER BY start_time DESC;
*/

SELECT 'Streamlit deployment completed successfully!' as final_status;
SELECT 'Hospital analytics dashboard is ready for clinical team demo!' as demo_ready;
