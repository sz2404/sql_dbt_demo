# Welcome to GG's dbt project!

## Vision
DBT is very power tool for structuring datasets within GG's domain and serves as version control on query definition. GG is a data driven company and different departments have customized needs for data view on carrying out further analysis. 
After processing and transforming the raw data, this project aims to create views that can be easy to locate, straight-forward to understand, and single source of truth to each departments. 

## Models Structure
- **Staging space**: staging space contains transformed dataset from raw/source data that can be ready to use for future analysis/modeling 
- **Modeled space**: the modeled space contains views developed for different departments & purposes, including:
    - company_kpi: company-wide usage, showing high-level summary of referrals
    - finance: commission calculation 
    - sales: stats for referral records - including complete referral records, and successful rates of both inbound and outbound referrals on a monthly basis, and summaries of monthly and regional referrals

## Assumptions
The referral raw dataset contains both inbound and outbound referrals. 
Based on the provided information, it is assumed that, a complete referral record would include an inbound and an outbound record. For example:
1. Consultant Harry from Partner Hogwarts connects with Customer Ron from Company Gryffindor
2. Harry introduced Ron to GG
The successful *inbound record* would show up as:

| id     | created_at | updated_at | company_id | partner_id | consultant_id | is_outbound |  status  |
|--------|-----------:|:----------:|:----------:|:----------:|:-------------:|:-----------:|:--------:|
| 1      | 2022-01-02 | 2022-02-01 | Gryffindor | Hogwarts   | Harry         |0            |successful|

3. Ron is happy to use GG's service 
4. Ron got connected to Consultant Luna from Partner Ravenclaws
5. Ron signed a deal with Luna
The successful *outbound record* would show up as:

| id     | created_at | updated_at | company_id | partner_id | consultant_id | is_outbound |  status  |
|--------|-----------:|:----------:|:----------:|:----------:|:-------------:|:-----------:|:--------:|
| 2      | 2022-02-03 | 2022-02-21 | Gryffindor | Ravenclaws | Luna          |1            |successful|

To make those two referrals for a complete referral record, it is assumed that once a company reached successful inbound referral, the query will look for a closest outbound referral that is created after it's inbound updated date.

## Visualization sample
A few different plots were generated in Google Colab notebook to visualize the processed datasets. 
Link to the [notebook](https://colab.research.google.com/drive/1aFFbXqrOjf7U_EYkPAzi97tp3f3Ut5kv#scrollTo=w6MmeBUBJ-9E

## Data Issues and Resolutions
There are sales manager names found in the partners dataset but do not exist in the sales people dataset. 
To resolve this issue, partners dataset was quickly reviewed in a [notebook] (https://colab.research.google.com/drive/1eip6HPE1-O5teBeBhdOaJtN6zQo8iArX?usp=share_link) and suggested values for imputing missing entries. Additional names were added in the sales people dataset.

A test was also created for future use to compare sales manager names from partners and from the sales people dataset to ensure all new coming sales manager are accounted for properly. 

## Further Improvements
If the above assumptions are correct, there are some additional features can be considered to make the analysis more robust and improve customer experience.
Some interesting features to include in the existing raw data can be:
1. Customer ID - easier to match the inbound and outbound record
    - assigned a Specific customer ID to a customer from a company
    - if the customer switch to a different company, a new ID can be assigned
2. Disinterest reasoning
    - Inbound: it can provide additional feedback for partners
    - Outbound: this can help GG to find out potential new product features and area to expand to
3. Sales Representative follow-up record 
    - Most of the records are in pending status
    - Follow-up records might be helpeful for the sales team to prioritize cilent meeting 

The raw data is possibly stored and managed in a data warehouse. Some potential datasets can be added to improve data service include:
1. The user worklogs 
    - Review user's worklogs can help the data team to identify department needs for data and select proper data warehouse/database/data lake products
    - The data team can look through how users are usaing different table or views to generate data they need, better dbt query can be implemented based on user's needs
2. Table/view processing stats 
    - With business expansion, more records will be generated. By reviewing processing stats, the data team can improve data relations and structure

### Using the starter project

Try running the following commands:
- dbt run
- dbt test

### Resources:
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [dbt community](http://community.getbdt.com/) to learn from other analytics engineers
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices
