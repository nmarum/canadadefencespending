# canadadefencespending
Open government data on defence spending in Canada

Data wrangling and exploratory analysis of publicly available data about National Defence and defence procurement.

All part of my own journey of learning and leveraging data.

All government data is subject to Open Government Licence - Canada

See https://open.canada.ca/en/open-government-licence-canada for more detail

Repo includes:

import_wrangling_public_accounts.R contains code for import and wrangling of several years of public accounts detailed data tables for defence equipment expenditures and produces amo_2010to2019.rda

public_accts_amo_analysis.R is the analysis of the amo_2010to2019.rda object

DND_approp_and_expenditures_since_2011.R is exploratory analysis of National Defence voted appropriations and expenditures by fiscal year since 2011.  It also includes a short analysis of expenditures by standard object.

defence_vendor_data.csv is a vendor name database that matches the names of many Government of Canada vendors identified in proactive disclosure contracts data with their parent companies.  I have manually updated a vendor database that was produced by an Ottawa Civic Tech project to reflect many major defence supplier parent companies and some recent M&A activity.

wrangling_DND_contracts.R is a data import and wrangling script that creates a DND contract database for analysis.

DND_contract_analysis.RMD is the R markdown of an exploratory analysis of DND contract data from 2010 to early 2020.

DND_contract_analysis.html is the html version of the markdown document.  I will look to update the analysis from time to time.
