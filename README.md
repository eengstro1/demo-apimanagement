___Definition:___
A service capability that allows api's to be published, managed, secured, and analyzed in minutes.

___Use Cases:___
The most common Uses Cases for the the Service.
1. __Enterprise API Catalog__ -- Expose API's for internal/external developers and provide them with a place to discover, learn and consume your API's.
1. __Customer and Partner Integration__ -- Expose API's to customer/partners and create a digital ecosystem that benefits the business
1. __Mobile Enablement and IoT__ -- Expose API's "securely" to millions of devices and protect them from misuse and abuse.
1. __API's as a business__ -- API's may be the sole product sold.  Discover, usage stats and monetization.
1. __Microservice Gateway__ -- API gateway to decouple a frontend  from microservices and do things like HTTPS offloading, request orchestration and API transformation.
Portal)

<img src='https://danielscholl.blob.core.windows.net/public/api_managment_price.png'/>

___Customer Story:___

[EarthNetworks](https://customers.microsoft.com/en-us/story/earthnetworks) - Making weather data available to customers through cloud-based applications and application programming interfaces.

[Developer Portal](https://developer.earthnetworks.com/) - https://developer.earthnetworks.com

<img src='https://danielscholl.blob.core.windows.net/public/api_management_components.png'/>

1. Developer Portal
   - Read Documentation
   - Interact with API's
   - Accounts and API Keys
   - ANalytics on personal usage

1. Gateway
    - Receives API calls and routes them.
    - Vaidates Keys and Tokens
    - Enforce quotas and limits
    - Transforms definitions real time
    - Caches responses
    - Logging

1. Publisher Portal (Azure Portal)
    - Define API's
    - Package API's into logical groupings
    - Set policies
    - Analytics
    - Manage Users of API's


### Deploy API Management

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fazure%2Fazure-quickstart-templates%2Fmaster%2F101-azure-api-management-create%2Fazuredeploy.json" target="_blank">
    <img src="http://azuredeploy.net/deploybutton.png"/>
</a>


### Sample API(s)

```bash
# API in Container
# ----------------

az container create --resource-group demo --name dks-demo-api \
  --image danielscholl/demoapi \
  --dns-name-label dks-demo \
  --ports 80


API in Function App
--------------------

```


