--01. Run this code in your Snowflake acccount to create the structures
CREATE DATABASE IF NOT EXISTS snowflake_intelligence;
GRANT USAGE ON DATABASE snowflake_intelligence TO ROLE PUBLIC;

CREATE SCHEMA IF NOT EXISTS snowflake_intelligence.agents;
GRANT USAGE ON SCHEMA snowflake_intelligence.agents TO ROLE PUBLIC;

--Optional if you want to give a role permission to the above
GRANT CREATE AGENT ON SCHEMA snowflake_intelligence.agents TO ROLE <role>;

--02. Enable cross region inference
ALTER ACCOUNT SET CORTEX_ENABLED_CROSS_REGION = 'ANY_REGION';

--03. Subcribe to Snowflake Documentation on Marketaplce (or you can do this from the Marketplace)
/*1. In Snowsight goto Marketplace
2. Search "Snowflake Documentation". click on Get. Follow the instrucions
3. You should see a new database in Snowsight called Snowflake Documentation

--04. Create AI Agent for LLM chat
/*1. In Snowsight goto AI & ML - Agents
2. Select Create Agent (top right)
3. Enter an object name for the agent
4. Enter the Display Name (this will show in Snowflake Intelligence)
5. Click Create Agent
*/

--05. Create agent to chat to Snowflake Documentation
/*1. Refresh Snowsight
2. Follow step 1-5 above
3. Click on agent to see the defintion
4. Click on edit, top right
5. Goto Tools
6. Add a Search Service
7. Select the Snowflake Documentation search service in database Snowflake_Documentatiom. "NOWFLAKE_DOCUMENTATION.SHARED.CKE_SNOWFLAKE_DOCS_SERVICE"
8. In Column, select "SOURCE_URL"
9. In Title column select, "DOCUMENT_TITLE"
10. Give it a name, Add
11. Save the agent

--06. You Should be able to chat to both now in Snowflake Intelligence.
