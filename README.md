[![GitHub](https://img.shields.io/badge/github-azure--pipelines--nodejs-blue.svg "notder")](https://github.com/notder/azure-pipelines-nodejs)

# Azure Pepelines NodeJS Docker Images
This image using [nodejs official image](https://hub.docker.com/_/node) for run self-hosted agents on Azure Pipelines

### [Running a self-hosted agent in Docker](https://docs.microsoft.com/en-us/azure/devops/pipelines/agents/docker?view=azure-devops)

# Supported tags and respective `Dockerfile` links

- `12`, `12.5.0` [Dockerfile](https://github.com/notder/azure-pipelines-nodejs/blob/master/Dockerfile)
- `10`, `10.16.0` [Dockerfile](https://github.com/notder/azure-pipelines-nodejs/blob/master/Dockerfile)
- `8`, `8.16.0 ` [Dockerfile](https://github.com/notder/azure-pipelines-nodejs/blob/master/Dockerfile)

### Build image
`docker build --build-arg NODE_VERSION=8 -t azure-pipelines-nodejs:8 .`

### Environment Variable Example
AZURE_REPOSITORY_URL: https://dev.azure.com/{your_organization}  
AZURE_TOKEN: XXXXXXXXXXXXXXXXXXXXXX [Setup](https://docs.microsoft.com/en-us/azure/devops/pipelines/agents/v2-linux?view=azure-devops#authenticate-with-a-personal-access-token-pat)  
AZURE_POOL: nodejs [Setup](https://docs.microsoft.com/en-us/azure/devops/pipelines/agents/pools-queues?view=azure-devops#creating-agent-pools) (`https://dev.azure.com/{your_organization}/_settings/agentpools`)  
AGENT_NAME: node-12



### Run docker
```
docker run -e AZP_URL=[AZURE_REPOSITORY_URL] -e AZP_TOKEN=[AZURE_TOKEN] -e AZP_AGENT_NAME=[AGENT_NAME] -e AZP_POOL=[AZURE_POOL] --name [CONTAINER_NAME] notder/azure-pipelines-nodejs:[TAG_NAME]
```

### Run docker-compose.yml
```
version: '3'
services:
  nodejs-12:
    image: notder/azure-pipelines-nodejs:12
    environment:
      AZP_POOL: nodejs
      AZP_AGENT_NAME: nodejs-12
      AZP_URL: https://dev.azure.com/{your_organization}
      AZP_TOKEN: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
    restart: always
    networks:
      - azure-nodejs-12-network

networks:
  azure-nodejs-12-network:
    driver: bridge
```

### Example `azure_pipelines.yml`
```
trigger:
  branches:
    include:
    - master
    - develop

jobs:
- job: build
  pool: 
    name: nodejs
  variables:
    COMMIT_ID: '$(Build.SourceVersion)'
  steps:
  - script: |
      npm install
      npm run build:prod
    displayName: 'NPM RUN BUILD'
```