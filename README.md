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

<img src='https://raw.githubusercontent.com/danielscholl/demo-apimanagement/master/images/api_management_price.png'/>

___Customer Story:___

[EarthNetworks](https://customers.microsoft.com/en-us/story/earthnetworks) - Making weather data available to customers through cloud-based applications and application programming interfaces.

[Developer Portal](https://developer.earthnetworks.com/) - https://developer.earthnetworks.com

<img src='https://github.com/danielscholl/demo-apimanagement/raw/master/images/api_management_components.png'/>

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


## API Source Code Samples

[OpenSpec API Sample Code](https://github.com/danielscholl/demo-apimanagement-apicode)
[PreCompiled CRUD Serverless Function Sample Code](https://github.com/danielscholl/demo-apimanagement-funcapp)

___Deploy API Management:___

<a href="https://portal.azure.com/#create/Microsoft.Template/urihttps%3A%2F%2Fraw.githubusercontent.com%2Fdanielscholl%2Fdemo-apimanagement%2Fmaster%2Ftemplates%2Fazuredeploy.json" target="_blank">
    <img src="http://azuredeploy.net/deploybutton.png"/>
</a>


__Deploy API Samples:__

```bash
# Set Variables up
# ----------------

Resource_Group="demo"
Prefix="75098"
Registry="eriksdemo"
Code="https://github.com/eengstro1/demo-apimanagement-funcapp.git"


# API in Container
# ----------------

az container create --name "${Prefix}-api" \
	--resource-group ${Resource_Group} \
	--image "${Registry}/demoapi" \
	--dns-name-label "${Prefix}-api" \
	--ports 80


# API in Function App
# --------------------

az storage account create --name "${Prefix}storage" \
    --resource-group ${Resource_Group} \
    --sku Standard_LRS \
    --location eastus2 

az functionapp create --name "${Prefix}-funcapp" \
    --resource-group ${Resource_Group} \
    --storage-account  "${Prefix}storage" \
    --deployment-source-url ${Code}  \
    --consumption-plan-location eastus2

az functionapp config appsettings set --name "${Prefix}-funcapp" \
    --resource-group ${Resource_Group} \
    --settings FUNCTIONS_EXTENSION_VERSION=beta
```

___Test API Samples:___

```bash
# Set Variables up
# ----------------
API="https://${Prefix}-funcapp.azurewebsites.net/api"

# Test Ping/Pong
curl ${API}/ping

# Test TODO
curl -i -H "Accept: application/json" -H "Content-Type: application/json" -X POST -d "{'tododescription': 'hello-world'}" ${API}/todo
curl ${API}/todo
```
