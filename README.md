# Azure Streamlit PoC 🐳🚀☁️

![PoC](https://img.shields.io/badge/Release_Stage-PoC-yellow?color=%23FF4500)

<img src="./images/website.png" alt="adr"/>

## Overview

I needed to create a quick proof of concept (PoC) using Streamlit but had two constraints:
- Self-host instead of using [Streamlit community cloud](https://streamlit.io/cloud)
- Control access to the deployed website

With this in mind, containerizing and hosting on Azure was the solution. This repository provides a boilerplate to fast track this with the following implementations:
- Containerized Streamlit app with a blank `app.py` file (just add your code).
- GitHub workflow to build and publish the image to `ghcr.io`.
- Terraform code to manage infrastructure on Azure.
- GitHub workflow to execute Terraform apply & destroy infrastructure.

I hope this helps you to ship more 🚀

## What is Streamlit? 🤔

Streamlit is an open-source Python library that makes it easy to create interactive web applications for machine learning and data science projects.

[Check it out](https://streamlit.io/)

## What's the damage (WTD)? 💰

| Description | Cost (Per month) |
| ---- | ----------- |
| **B1** ($0.075/hour) tier for [Azure App Service costing](https://azure.microsoft.com/en-us/pricing/details/app-service/windows/#pricing) | $54.79 |
| Standard tier with LRS for [Azure Storage Account costing](https://azure.microsoft.com/en-us/pricing/details/storage/blobs/) (10K+ operations cost excluded as minimal usage) | $0.0184 |
| GitHub Workflows (if private repo, check [pricing](https://github.com/pricing)) | $0 |
|  **Total**   | $54.81 |

**Disclaimer**: Estimation only. Pricing might change; please refer to official documentation at the time of evaluation.

## Technologies Used 🧑‍💻

![Azure](https://img.shields.io/badge/azure-%230072C6.svg?style=for-the-badge&logo=microsoftazure&logoColor=white)
![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white)
![Terraform](https://img.shields.io/badge/terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white)
![GitHub Actions](https://img.shields.io/badge/github%20actions-%232671E5.svg?style=for-the-badge&logo=githubactions&logoColor=white)
![Python](https://img.shields.io/badge/python-3670A0?style=for-the-badge&logo=python&logoColor=ffdd54)

## Hosting and Deployment 🚀

- Hosting: Azure App Service.
- Deployment: GitHub Actions

## Architecture Overview 🏛️

- Interactive web-based frontend.
- Python-based backend.
- GitHub Container Registry to store the image.

## Getting Started 🧑‍💻

**Coming soon**

## License 📝

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.