# Azure Streamlit PoC 🐳🚀☁️

![PoC](https://img.shields.io/badge/Release_Stage-PoC-yellow?color=%23FF4500)

![streamlit](./images/website.png)

## Overview

I needed to create a quick proof of concept (PoC) using Streamlit but had two constraints:

- Self-host instead of using [Streamlit community cloud](https://streamlit.io/cloud)
- Control access to the deployed website

With this in mind, containerizing and hosting on Azure was the solution. This repository provides a boilerplate to fast-track this with the following implementations:

- Containerized Streamlit app with a blank `app.py` file (just add your code).
- GitHub workflow to build and publish the image to `ghcr.io`.
- Terraform code to manage infrastructure on Azure (Azure Container Apps).
- GitHub workflow to execute Terraform apply & destroy infrastructure.

I hope this helps you to ship more 🚀

## What is Streamlit? 🤔

Streamlit is an open-source Python library that makes it easy to create interactive web applications for machine learning and data science projects.

[Check it out](https://streamlit.io/)

## What's the damage (WTD)? 💰

| Description | Cost (Per month) |
| ---- | ----------- |
| [Azure Container Apps Consumption](https://azure.microsoft.com/en-us/pricing/details/container-apps/) — scale-to-zero, free tier covers 180,000 vCPU-seconds, 360,000 GiB-seconds, and 2M requests | ~$0 (PoC, idle) |
| [Log Analytics workspace](https://azure.microsoft.com/en-us/pricing/details/monitor/) — first 5 GB ingestion free, low-volume PoC stays under | ~$0 |
| Standard tier with LRS for [Azure Storage Account costing](https://azure.microsoft.com/en-us/pricing/details/storage/blobs/) (Terraform state, minimal operations) | $0.0184 |
| GitHub Workflows (if private repo, check [pricing](https://github.com/pricing)) | $0 |
|  **Total**   | ~$0.02 |

**Disclaimer**: Estimation only. Pricing might change; please refer to the official documentation at the time of evaluation. Active traffic, sustained replicas, or high request volume will increase Container Apps cost beyond the free grant.

## Technologies Used 🧑‍💻

![Azure](https://img.shields.io/badge/azure-%230072C6.svg?style=for-the-badge&logo=microsoftazure&logoColor=white)
![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white)
![Terraform](https://img.shields.io/badge/terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white)
![GitHub Actions](https://img.shields.io/badge/github%20actions-%232671E5.svg?style=for-the-badge&logo=githubactions&logoColor=white)
![Python](https://img.shields.io/badge/python-3670A0?style=for-the-badge&logo=python&logoColor=ffdd54)

## Hosting and Deployment 🚀

- Hosting: Azure Container Apps (Consumption tier, scale-to-zero by default).
- Deployment: GitHub Actions

## Architecture Overview 🏛️

- Interactive web-based frontend.
- Python-based backend.
- GitHub Container Registry to store the image.

## Getting Started 🧑‍💻

> This project requires an Azure subscription to run, [Get started](https://azure.microsoft.com/en-us/)

1. Create a repository from this template repo.
2. Open a shell and run `azure login`
3. Update the subject field within your repository naming in infra/scripts/credential.json
4. Execute infra/scripts/initialize.sh and capture output fields
5. Setting up the environment:

	- Navigate to your repository on GitHub.
	- Go to “Settings” > “Environments”.
	- Create a new environment 'production'

6. Adding Secrets:

	- Navigate to your repository on GitHub.
	- Go to “Settings” > “Environments” > Select “production”.
	- Go to "Environment secrets" and select "Add environment secret"
	- Add the following secrets using the output of step 4: AZURE_ENTRA_ID_CLIENT_ID, AZURE_ENTRA_ID_TENANT_ID & AZURE_SUBSCRIPTION_ID

## Development

> To begin, make sure you have the [Dev containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) installed and have [Docker](https://www.docker.com/products/docker-desktop/) running. Check out [Devcontainers](https://containers.dev/) for context.

1. **Clone** this repo and open it in **Visual Studio Code**.
2. You should see this notification pop up:

![devcontainerprompt](./images/devcontainerprompt.png)

    Select _Reopen in Container_ and the devcontainer will be loaded.

This will prepare your dev environment with the required tooling.

### Using a special button

This will open this repo in Visual Studio Code using a _link_. Press below:

[
    ![Open in Remote - Containers](
        https://img.shields.io/static/v1?label=Dev%20Containers&message=Open&color=blue&logo=visualstudiocode    )
](
    https://vscode.dev/redirect?url=vscode://ms-vscode-remote.remote-containers/cloneInVolume?url=https://github.com/WayneGoosen/azure-streamlit-poc
)

## License 📝

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
